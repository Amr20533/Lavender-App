class SessionModel {
  final int id;
  final String doctorName;
  final String doctorImage;
  final String specialty;
  final DateTime date;
  final String status; // 'Upcoming', 'Completed', 'Cancelled'
  final bool isGroup;
  final double? price;
  final String? groupImage;
  final int? attendees;
  final int? maxAttendees;
  final String time;

  SessionModel({
    required this.id,
    required this.doctorName,
    required this.doctorImage,
    required this.specialty,
    required this.date,
    required this.status,
    this.isGroup = false,
    this.price,
    this.groupImage,
    this.attendees,
    this.maxAttendees,
    required this.time,
  });
}
