import 'package:lavender/features/profile/data/models/UserProfile.dart';
import 'package:lavender/features/programs/data/models/free_programs/program_session.dart';

class FreeProgram {
  final String id;
  final UserProfile author;
  final String title;
  final String image;
  final String category;
  final int viewersNumber;
  final List<ProgramSession> sessions;
  final String? nextSessionDate;

  FreeProgram({
    required this.id,
    required this.author,
    required this.title,
    required this.image,
    required this.viewersNumber,
    required this.sessions,
    required this.category,
    this.nextSessionDate,
  });

  factory FreeProgram.fromJson(Map<String, dynamic> json) {
    return FreeProgram(
      id: json['id'] ?? '',
      author: UserProfile.fromJson(json['author'] ?? {}),
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      viewersNumber: json['viewers_number'] ?? 0,
      sessions: (json['sessions'] as List?)
          ?.map((s) => ProgramSession.fromJson(s))
          .toList() ?? [],
      nextSessionDate: json['next_session_date'],
    );
  }
}