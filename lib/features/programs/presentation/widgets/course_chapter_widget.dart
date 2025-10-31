import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavender/core/themes/app_colors.dart';

class CourseChapterWidget extends StatelessWidget {
  final String chapter;
  final String chapterTitle;
  final List<LessonModel> lessons;

  const CourseChapterWidget({
    super.key,
    required this.chapterTitle,
    required this.lessons,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                chapter,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColorDarkText,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                chapterTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.button,
                ),
              ),
            ],
          ),
        ),
        ...lessons.map((lesson) {
          return LessonTile(lesson: lesson);
        }).toList(),
      ],
    );
  }
}

class LessonTile extends StatelessWidget {
  final LessonModel lesson;

  const LessonTile({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    lesson.isLocked
                        ? 'assets/svg/Frame 1597882424.svg'
                        : 'assets/svg/tick-circle.svg.svg',
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      lesson.isLocked ? Colors.grey : Colors.green,
                      BlendMode.srcIn,
                    ),
                  ),

                  Positioned(
                    left: 40,
                    bottom: -20,
                    child: Container(
                      width: 2,
                      height: 80,
                      color: AppColors.button.withOpacity(0.3),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${lesson.number.toString().padLeft(2, '0')}  ${lesson.title}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.duration,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              SvgPicture.asset(
                "assets/svg/Frame 1597882414.svg",
                color: AppColors.button.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LessonModel {
  final int number;
  final String title;
  final String duration;
  final bool isLocked;
  final bool hasLine;

  LessonModel({
    required this.number,
    required this.title,
    required this.duration,
    this.isLocked = true,
    this.hasLine = false,
  });
}
