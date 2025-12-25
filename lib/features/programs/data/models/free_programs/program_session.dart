

import 'package:lavender/features/programs/data/models/free_programs/session_item.dart' show SessionItem;

class ProgramSession {
  final int id;
  final String title;
  final String status;
  final String? video;
  final int duration;
  final String formattedDate;
  final List<SessionItem> items;

  ProgramSession({
    required this.id,
    required this.title,
    required this.status,
    this.video,
    required this.duration,
    required this.formattedDate,
    required this.items,
  });

  factory ProgramSession.fromJson(Map<String, dynamic> json) {
    return ProgramSession(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      video: json['video'],
      duration: json['duration'] ?? 0,
      formattedDate: json['formatted_date'] ?? '',
      items: (json['items'] as List?)
          ?.map((i) => SessionItem.fromJson(i))
          .toList() ?? [],
    );
  }
}
