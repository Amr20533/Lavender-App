
import 'package:lavender/features/home/data/models/appointment.dart';
import 'package:lavender/features/profile/data/models/user.dart';

class Specialist {
  final User user;
  final String profilePic;
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String role;
  final String bio;
  final String country;
  final int yearsOfExperience;
  final String pricePerHour;
  final double avgRating;
  final String speciality;
  final String extraSpecialty;
  final int prevCount;
  final int availableCount;
  final List<Appointment> appointments;

  Specialist({
    required this.user,
    required this.profilePic,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.role,
    required this.bio,
    required this.country,
    required this.yearsOfExperience,
    required this.pricePerHour,
    required this.avgRating,
    required this.speciality,
    required this.extraSpecialty,
    required this.prevCount,
    required this.availableCount,
    required this.appointments,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      user: User.fromJson(json['user']),
      profilePic: json['profile_pic'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      role: json['role'] ?? '',
      bio: json['bio'] ?? '',
      country: json['country'] ?? '',
      yearsOfExperience: json['years_of_experience'] ?? 0,
      pricePerHour: json['price_per_hour'] ?? '',
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      speciality: json['speciality'] ?? '',
      extraSpecialty: json['extra_specialty'] ?? '',
      prevCount: json['prev_count'] ?? 0,
      availableCount: json['available_count'] ?? 0,
      appointments: (json['appointments'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'profile_pic': profilePic,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone_number': phoneNumber,
      'role': role,
      'bio': bio,
      'country': country,
      'years_of_experience': yearsOfExperience,
      'price_per_hour': pricePerHour,
      'avg_rating': avgRating,
      'speciality': speciality,
      'extra_specialty': extraSpecialty,
      'prev_count': prevCount,
      'available_count': availableCount,
      'appointments': appointments.map((a) => a.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Specialist(user: $user, speciality: $speciality, appointments: $appointments)';
  }

}
