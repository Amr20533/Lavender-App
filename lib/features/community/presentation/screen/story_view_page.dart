
import 'package:flutter/material.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

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

  @override
  void initState() {
    super.initState();
    _buildStoryItems();
  }

  void _buildStoryItems() {
    storyItems = widget.story.stories.map((story) {
      // If image exists → normal image story
      if (story.image != null) {
        return StoryItem.inlineImage(
          url: story.image!,
          controller: controller,
          caption: Text(
            story.caption ?? "",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: widget.onComplete,
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
                const Spacer(),
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
