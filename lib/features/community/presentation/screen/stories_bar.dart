import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:lavender/features/community/presentation/cubit/story_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/story_states.dart';
import 'package:lavender/features/community/presentation/screen/story_view_screen.dart';
import 'package:lavender/features/community/presentation/widgets/add_story_bottom_sheet.dart';
import 'package:lavender/features/community/presentation/widgets/add_story_circle.dart';
import 'package:lavender/features/community/presentation/widgets/story_picker_helper.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../core/widget/custom_cached_network_image.dart';

class StoriesBar extends StatefulWidget {
  const StoriesBar({super.key});

  @override
  State<StoriesBar> createState() => _StoriesBarState();
}

class _StoriesBarState extends State<StoriesBar> {

  @override
  void initState() {
    super.initState();
    context.read<StoryCubit>().fetchStories();
    context.read<ProfileCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: BlocBuilder<StoryCubit, StoryStates>(
        builder: (context, state) {

          if (state is StoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StoryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is StoryLoaded) {
            final stories = state.stories;

            return ListView.separated(
              key: const PageStorageKey('stories_list'),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const BouncingScrollPhysics(),
              itemCount: stories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AddStoryCircle(
                    onTap: () => _showAddStoryOptions(),
                  );
                }

                final story = stories[index - 1];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _navigateToStoryView(stories, index - 1),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.circleGradient,
                            ),
                            child: ClipOval(
                              child: CustomCachedNetworkImage(
                                imageUrl: "${story.profilePic}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                          const SizedBox(height: 6),

                          SizedBox(
                            width: 70,
                            child: Text(
                              "${story.firstName} ${story.lastName}",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder:  (context, _) => SizedBox(width: 12,),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _showAddStoryOptions() {
    AddStoryBottomSheet.show(
      context,
      onPickImage: (source) => StoryPickerHelper.pickImage(context, source),
      onPickVideo: (source) => StoryPickerHelper.pickVideo(context, source),
    );
  }

  void _navigateToStoryView(List<UserStories> stories, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewScreen(
          stories: stories,
          initialIndex: index,
        ),
      ),
    );
  }
}
