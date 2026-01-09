import 'package:lavender/features/programs/data/models/exercises/breathing_step.dart';

class ExerciseModel {
  final String title;
  final String description;
  final List<BreathingStep> steps;

  ExerciseModel({
    required this.title,
    required this.description,
    required this.steps,
  });

  static final List<Map<String, dynamic>> breathingExercises = [
    {
      "id": 1,
      "title": "تمرين التنفس العميق",
      "description": "اتبع الدائرة وتنفس بعمق للاسترخاء وتقليل التوتر",
      "image": "assets/images/breathing_circle.png",
      "duration_total": "5 دقائق",
      "steps": [
        {"action": "استنشاق", "duration": 4, "instruction": "استنشق ببطء من الأنف"},
        {"action": "توقف", "duration": 4, "instruction": "احبس نفسك قليلاً"},
        {"action": "زفير", "duration": 4, "instruction": "أخرج الهواء ببطء من الفم"},
      ],
      "category": "استرخاء"
    },
    {
      "id": 2,
      "title": "تنفس 4-7-8",
      "description": "تقنية فعالة للنوم العميق وتهدئة الأعصاب",
      "image": "assets/images/sleep_breath.png",
      "duration_total": "3 دقائق",
      "steps": [
        {"action": "استنشاق", "duration": 4},
        {"action": "توقف", "duration": 7},
        {"action": "زفير", "duration": 8},
      ],
      "category": "نوم"
    }
  ];
}