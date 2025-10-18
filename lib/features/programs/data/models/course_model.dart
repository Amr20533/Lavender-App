import 'package:lavender/features/home/data/models/specialist.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String category;
  final double price;
  final double avgRating;
  final int duration;
  final int totalSessions;
  final List<dynamic> videos;
  final DateTime createdAt;
  final Specialist instructor;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
    required this.avgRating,
    required this.duration,
    required this.totalSessions,
    required this.videos,
    required this.createdAt,
    required this.instructor,
  });

  /// ✅ Factory constructor for creating from JSON safely
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      price: _parseDouble(json['price']),
      avgRating: _parseDouble(json['avg_rating']),
      duration: _parseInt(json['duration']),
      totalSessions: _parseInt(json['total_sessions']),
      videos: (json['videos'] is List) ? json['videos'] as List : [],
      createdAt: _parseDate(json['created_at']),
      instructor: Specialist.fromJson(json['instructor'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'category': category,
      'price': price,
      'avg_rating': avgRating,
      'duration': duration,
      'total_sessions': totalSessions,
      'videos': videos,
      'created_at': createdAt.toIso8601String(),
      'instructor': instructor.toJson(),
    };
  }

  /// Safe parsing helpers
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }
}
