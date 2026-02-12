import 'dart:convert';

class DiaryEntry {
  final String id;
  final String text;
  final String emoji;
  final int colorValue;
  final DateTime date;

  DiaryEntry({
    required this.id,
    required this.text,
    required this.emoji,
    required this.colorValue,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'emoji': emoji,
      'colorValue': colorValue,
      'date': date.toIso8601String(),
    };
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      emoji: map['emoji'] ?? '',
      colorValue: map['colorValue'] ?? 0xFF8B7FD8,
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryEntry.fromJson(String source) =>
      DiaryEntry.fromMap(json.decode(source));
}