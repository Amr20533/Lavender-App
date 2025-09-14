import 'dart:convert';

class Quiz {
  final String id;
  final String title;
  final String? image;
  final DateTime? createdAt;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
    this.image,
    this.createdAt,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    if (image != null) 'image': image,
    if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    'questions': questions.map((q) => q.toJson()).toList(),
  };
}

class Question {
  final int id;
  final String text;
  final int order;
  final List<Answer> answers;

  Question({
    required this.id,
    required this.text,
    required this.order,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      text: json['text'] as String,
      order: (json['order'] as num).toInt(),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'order': order,
    'answers': answers.map((a) => a.toJson()).toList(),
  };
}

class Answer {
  final int id;
  final String text;
  final int score;

  Answer({
    required this.id,
    required this.text,
    required this.score,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int,
      text: json['text'] as String,
      score: (json['score'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'score': score,
  };
}

/// Convenience parser for the top-level list response:
List<Quiz> parseQuizzesResponse(String jsonString) {
  final data = json.decode(jsonString);
  if (data is List) {
    return data.map((e) => Quiz.fromJson(e as Map<String, dynamic>)).toList();
  }
  throw FormatException('Expected a JSON list of quizzes');
}
