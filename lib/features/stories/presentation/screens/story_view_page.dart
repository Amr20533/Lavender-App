// 4️⃣ صفحة Story واحدة (باستخدام الـ Package)
import 'package:flutter/material.dart';
import 'package:lavender/features/stories/data/models/user_story_model.dart' hide StoryItem;
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final UserStory user;
  final VoidCallback onComplete;
  final VoidCallback onPrevious;

  StoryViewPage({
    required this.user,
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
    storyItems = widget.user.stories.map((story) {
      if (story.isVideo) {
        // للفيديو
        return StoryItem.pageVideo(
          story.url,
          controller: controller,
          duration: story.duration,
          caption: Text(
            widget.user.name,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        );
      } else {
        // للصورة
        return StoryItem.inlineImage(
          url: story.url,
          controller: controller,
          caption: Text(
            widget.user.name,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        );
      }
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
          onStoryShow: (storyItem, index) {
            print('Showing story at index: $index');
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
          inline: false,
        ),
        // Header مع اسم المستخدم
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.user.profileImage),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.user.name,
                    style: TextStyle(
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
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
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