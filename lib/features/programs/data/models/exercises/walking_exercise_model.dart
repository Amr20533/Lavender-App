class WalkingExerciseModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String durationTotal;
  final List<WalkingStep> steps;
  final String category;

  WalkingExerciseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.durationTotal,
    required this.steps,
    required this.category,
  });

  static final List<Map<String, dynamic>> walkingExercises = [
    {
      "id": 1,
      "title": "المشي الواعي بالحواس",
      "description": "استخدم حواسك الخمس أثناء المشي للتحرر من الأفكار المقلقة",
      "image": "assets/images/mindful_walk.png",
      "duration_total": "10 دقائق",
      "steps": [
        {"action": "تركيز", "duration": 2, "instruction": "لاحظ ملمس قدمك على الأرض مع كل خطوة"},
        {"action": "استماع", "duration": 2, "instruction": "انتبه لـ 3 أصوات بعيدة من حولك"},
        {"action": "استنشاق", "duration": 2, "instruction": "لاحظ الروائح في الهواء المحيط بك"},
        {"action": "ملاحظة", "duration": 4, "instruction": "ركز على حركة ذراعيك وتناغمها مع جسدك"},
      ],
      "category": "تأريض (Grounding)"
    },
    {
      "id": 2,
      "title": "مشي تفريغ الغضب",
      "description": "تخلص من الطاقة السلبية عبر خطوات حازمة ومنتظمة",
      "image": "assets/images/power_walk.png",
      "duration_total": "15 دقيقة",
      "steps": [
        {"action": "إحماء", "duration": 3, "instruction": "ابدأ بمشية هادئة مع تحريك الكتفين"},
        {"action": "تسريع", "duration": 7, "instruction": "زد سرعة خطواتك مع زفير قوي ومسموع"},
        {"action": "تهدئة", "duration": 5, "instruction": "عد للسرعة الطبيعية وركز على استقرار نبضك"},
      ],
      "category": "تفريغ انفعالي"
    }
  ];
}

class WalkingStep {
  final String action;
  final int duration; // بالدقائق أو الثواني
  final String instruction;

  WalkingStep({
    required this.action,
    required this.duration,
    required this.instruction,
  });
}