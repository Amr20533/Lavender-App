import 'package:flutter/material.dart';
import 'package:lavender/features/stories/data/models/user_story_model.dart';
import 'package:lavender/features/stories/presentation/screens/story_view_page.dart';

class StoryViewScreen extends StatefulWidget {
  final List<UserStory> users;
  final int initialIndex;

  StoryViewScreen({
    required this.users,
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
        itemCount: widget.users.length,
        onPageChanged: (index) {
          setState(() {
            currentUserIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return StoryViewPage(
            user: widget.users[index],
            onComplete: () {
              // الانتقال للمستخدم التالي
              if (index < widget.users.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context);
              }
            },
            onPrevious: () {
              // الرجوع للمستخدم السابق
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