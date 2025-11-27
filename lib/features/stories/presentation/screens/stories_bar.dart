import 'package:flutter/material.dart';
import 'package:lavender/features/stories/data/models/user_story_model.dart';
import 'package:lavender/features/stories/presentation/screens/story_view_screen.dart';
import 'package:lavender/features/stories/presentation/widgets/add_story_bottom_sheet.dart';
import 'package:lavender/features/stories/presentation/widgets/add_story_circle.dart';
import 'package:lavender/features/stories/presentation/widgets/story_circle.dart';
import 'package:lavender/features/stories/presentation/widgets/story_picker_helper.dart';

class StoriesBar extends StatefulWidget {
  @override
  State<StoriesBar> createState() => _StoriesBarState();
}

class _StoriesBarState extends State<StoriesBar> {
  // Mock Data - استبدليها بالـ data الحقيقية بتاعتك
  final List<UserStory> users = [
    UserStory(
      name: 'خالد السيد',
      profileImage: 'https://i.pravatar.cc/150?img=1',
      hasUnseen: true,
      stories: [
        StoryItem(url: 'https://picsum.photos/400/700?random=1'),
        StoryItem(url: 'https://picsum.photos/400/700?random=2'),
      ],
    ),
    UserStory(
      name: 'حنان احمد',
      profileImage: 'https://i.pravatar.cc/150?img=5',
      hasUnseen: true,
      stories: [
        StoryItem(url: 'https://picsum.photos/400/700?random=3'),
      ],
    ),
    UserStory(
      name: 'أماني محمد',
      profileImage: 'https://i.pravatar.cc/150?img=9',
      hasUnseen: false,
      stories: [
        StoryItem(url: 'https://picsum.photos/400/700?random=4'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: ListView.builder(
        key: PageStorageKey('stories_list'),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8),
        physics: BouncingScrollPhysics(),
        itemCount: users.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddStoryCircle(
              onTap: () => _showAddStoryOptions(),
            );
          }
          
          final user = users[index - 1];
          return StoryCircle(
            user: user,
            onTap: () => _navigateToStoryView(index - 1),
          );
        },
      ),
    );
  }

  /// عرض Bottom Sheet لإضافة Story
  void _showAddStoryOptions() {
    AddStoryBottomSheet.show(
      context,
      onPickImage: (source) => StoryPickerHelper.pickImage(context, source),
      onPickVideo: (source) => StoryPickerHelper.pickVideo(context, source),
    );
  }

  /// الانتقال لصفحة عرض الـ Stories
  void _navigateToStoryView(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewScreen(
          users: users,
          initialIndex: index,
        ),
      ),
    );
  }
}