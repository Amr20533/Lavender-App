import 'package:flutter/material.dart';
import 'package:lavender/features/stories/data/models/user_story_model.dart';

/// Widget لدائرة Story الخاصة بكل مستخدم
class StoryCircle extends StatelessWidget {
  final UserStory user;
  final VoidCallback onTap;

  const StoryCircle({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: user.hasUnseen
                    ? LinearGradient(
                        colors: [Colors.purple, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: user.hasUnseen
                    ? null
                    : Border.all(color: Colors.grey[300]!, width: 2),
              ),
              padding: EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                    image: NetworkImage(user.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 70,
              child: Text(
                user.name,
                style: TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
