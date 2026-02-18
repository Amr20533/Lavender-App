import 'package:flutter/material.dart';

class ActivityModel {
  final String id;
  final String title;
  final String time;
  final IconData? icon;
  final String? svgPath;
  final bool isCompleted;

  ActivityModel({
    required this.id,
    required this.title,
    required this.time,
    this.icon,
    this.svgPath,
    this.isCompleted = false,
  });

  ActivityModel copyWith({
    String? id,
    String? title,
    String? time,
    IconData? icon,
    String? svgPath,
    bool? isCompleted,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      icon: icon ?? this.icon,
      svgPath: svgPath ?? this.svgPath,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static final List<ActivityModel> defaultActivities = [
    ActivityModel(
      id: "1",
      title: "15د موسيقى",
      time: "12:30 م",
      svgPath: "assets/svg/music-note-03.svg",
      isCompleted: true,
    ),
    ActivityModel(
      id: "2",
      title: "30د مشي",
      time: "12:30 م",
      svgPath: "assets/svg/elements (1).svg",
    ),
    // ActivityModel(
    //   id: "3",
    //   title: "تمارين التنفس",
    //   time: "12:30 م",
    //   svgPath: "assets/svg/elements.svg",
    // ),
  ];
}