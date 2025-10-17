import 'package:lavender/features/home/data/models/specialist.dart';

class DoctorBasicInfo {
  final String firstName;
  final String lastName;
  final String profilePic;
  final String speciality;
  final double avgRating;
  final int id;

  DoctorBasicInfo({
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.speciality,
    required this.avgRating,
    required this.id
  });

  factory DoctorBasicInfo.fromSpecialist(Specialist specialist) {
    return DoctorBasicInfo(
      firstName: specialist.user.firstName,
      lastName: specialist.user.lastName,
      profilePic: specialist.profilePic,
     speciality: specialist.speciality, 
     avgRating: specialist.avgRating,
     id: specialist.user.id,

    );
  }
}
