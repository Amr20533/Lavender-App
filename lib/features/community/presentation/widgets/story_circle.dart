import 'package:flutter/material.dart';
import 'package:lavender/features/community/data/models/story_model.dart';

/// Widget لدائرة Story الخاصة بكل مستخدم
class StoryCircle extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    required this.story,
    required this.onTap,
  });

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
                gradient: story.isSeen
                    ? LinearGradient(
                        colors: [Colors.purple, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: story.isSeen
                    ? null
                    : Border.all(color: Colors.grey[300]!, width: 2),
              ),
              padding: EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: DecorationImage(
                    image: NetworkImage(story.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 70,
              child: Text(
                '${story.caption}',
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
