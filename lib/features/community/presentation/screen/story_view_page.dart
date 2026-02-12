
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:lavender/features/community/presentation/cubit/story_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/story_states.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:story_view/controller/story_controller.dart';

class StoryViewPage extends StatefulWidget {
  final UserStories story;
  final VoidCallback onComplete;
  final VoidCallback onPrevious;

  const StoryViewPage({
    super.key,
    required this.story,
    required this.onComplete,
    required this.onPrevious,
  });

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];
  int currentStoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _buildStoryItems();
  }

  void _buildStoryItems() {
    storyItems = widget.story.stories.map((story) {
      // If image exists
      if (story.image != null) {
        final imagePath = story.image!;
        final bool isNetwork = imagePath.startsWith('http') || imagePath.startsWith('https');

        return StoryItem(
          Stack(
            fit: StackFit.expand,
            children: [
              isNetwork
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, event) {
                        if (event == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                           child: Icon(Icons.error, color: Colors.white),
                        );
                      },
                    )
                  : Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
              if (story.caption != null && story.caption!.isNotEmpty)
                 Positioned(
                   bottom: 40,
                   left: 16,
                   right: 16,
                   child: Text(
                      story.caption!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        backgroundColor: Colors.black54,
                      ),
                   ),
                 ),
            ],
          ),
          duration: const Duration(seconds: 5),
        );
      }

      // If no image → text story
      return StoryItem.text(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        title: story.caption ?? "",
        backgroundColor: Colors.black,
      );
    }).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays} ي"; // Days
    } else if (duration.inHours > 0) {
      return "${duration.inHours} س"; // Hours
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} د"; // Minutes
    } else {
      return "الآن"; // Just now
    }
  }

  void _handleDelete() {
    if (currentStoryIndex >= 0 && currentStoryIndex < widget.story.stories.length) {
      final storyToDelete = widget.story.stories[currentStoryIndex];
      context.read<StoryCubit>().deleteStory(storyToDelete.id, widget.story.id);
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: widget.onComplete,
          onStoryShow: (storyItem, index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
               if (mounted) {
                 setState(() {
                   currentStoryIndex = index;
                 });
               }
            });
          },
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
          inline: false,
        ),

        // ---------------- HEADER ------------------
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.story.profilePic != null
                      ? NetworkImage(widget.story.profilePic!)
                      : null,
                  child: widget.story.profilePic == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.story.firstName} ${widget.story.lastName}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                    if (currentStoryIndex >= 0 && currentStoryIndex < widget.story.stories.length)
                      Text(
                         _formatDuration(DateTime.now().difference(widget.story.stories[currentStoryIndex].createdAt)),
                         style: const TextStyle(
                           color: Colors.white70,
                           fontSize: 12,
                           shadows: [
                             Shadow(
                               blurRadius: 4,
                               color: Colors.black45,
                             ),
                           ],
                         ),
                      ),
                  ],
                ),
                const Spacer(),
                
                // Delete Button - Show only if it's "Me" (id=0 or check logic) 
                // In StoryCubit I used userId (from CurrentUserCubit).
                // Here I have `widget.story.id`.
                // I need to know if `widget.story.id` matches current user ID to show delete button.
                // Accessing CurrentUserCubit here again to check.
                BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                  builder: (context, state) {
                    if (state is CurrentUserProfileLoaded) {
                      if (state.currentUserInfoResponse.profile.user.id == widget.story.id) {
                        return IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: _handleDelete,
                        );
                      }
                    }
                    // Also support the mock "Me" user with ID 99999 if I used that ( I used actual ID in Cubit fix).
                    // But if I used actual ID, it should match.
                    return const SizedBox.shrink();
                  }
                ),

                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
