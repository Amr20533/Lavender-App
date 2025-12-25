class QuizResultModel {
  final int id;
  final String quizTitle;
  final String userEmail;
  final int totalScore;
  final double percentage;
  final String resultTitle;
  final String description;
  final DateTime createdAt;

  QuizResultModel({
    required this.id,
    required this.quizTitle,
    required this.userEmail,
    required this.totalScore,
    required this.percentage,
    required this.resultTitle,
    required this.description,
    required this.createdAt,
  });

  // Factory constructor to create a QuizResultModel from JSON
  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      id: json['id'] ?? 0,
      quizTitle: json['quiz'] ?? '',
      userEmail: json['user'] ?? '',
      totalScore: json['total_score'] ?? 0,
      // Ensures percentage is always a double even if API returns an int
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      resultTitle: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Optional: Convert model back to Map if you need to cache it locally
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz': quizTitle,
      'user': userEmail,
      'total_score': totalScore,
      'percentage': percentage,
      'title': resultTitle,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}