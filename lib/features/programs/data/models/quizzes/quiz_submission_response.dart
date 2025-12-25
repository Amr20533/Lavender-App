import 'dart:convert';

class QuizSubmissionResponse {
  final SubmittedAnswer answer;
  final QuizResult result;

  QuizSubmissionResponse({
    required this.answer,
    required this.result,
  });

  factory QuizSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return QuizSubmissionResponse(
      answer: SubmittedAnswer.fromJson(json['answer'] ?? {}),
      result: QuizResult.fromJson(json['result'] ?? {}),
    );
  }
}

class SubmittedAnswer {
  final int id;
  final int question;
  final int answer;

  SubmittedAnswer({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory SubmittedAnswer.fromJson(Map<String, dynamic> json) {
    return SubmittedAnswer(
      id: json['id'] ?? 0,
      question: json['question'] ?? 0,
      answer: json['answer'] ?? 0,
    );
  }
}

class QuizResult {
  final int id;
  final String quizName;
  final String userEmail;
  final int totalScore;
  final double percentage;
  final String title;
  final String description;
  final DateTime createdAt;

  QuizResult({
    required this.id,
    required this.quizName,
    required this.userEmail,
    required this.totalScore,
    required this.percentage,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'] ?? 0,
      quizName: json['quiz'] ?? '',
      userEmail: json['user'] ?? '',
      totalScore: json['total_score'] ?? 0,
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}