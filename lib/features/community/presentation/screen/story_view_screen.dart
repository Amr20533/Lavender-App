import 'package:flutter/material.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:lavender/features/community/presentation/screen/story_view_page.dart';

class StoryViewScreen extends StatefulWidget {
  final List<UserStories> stories;
  final int initialIndex;

  const StoryViewScreen({super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  _StoryViewScreenState createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late PageController _pageController;
  int currentUserIndex = 0;

  @override
  void initState() {
    super.initState();
    currentUserIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.stories.length,
        onPageChanged: (index) {
          setState(() {
            currentUserIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final userStories = widget.stories[index];

          return StoryViewPage(
            story: userStories,
            onComplete: () {
              if (index < widget.stories.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context);
              }
            },
            onPrevious: () {
              if (index > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          );
        },
      ),
    );
  }
}