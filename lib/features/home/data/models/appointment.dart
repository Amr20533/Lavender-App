
class Appointment {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String price;
  final bool isBooked;

  Appointment({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.isBooked,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      price: json['price'] ?? '',
      isBooked: json['is_booked'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'price': price,
      'is_booked': isBooked,
    };
  }

  @override
  String toString() {
    return 'Appointment(id: $id, date: $date, start: $startTime, end: $endTime)';
  }

}
