import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/features/home/widgets/specialists_card.dart';

class TripCards extends StatelessWidget {
  const TripCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: [
        SpecialistCard(
          text: "اخصائي نفسي",
          imagePath: "assets/images/Frame1_of_specialists.png",
        ),
        SpecialistCard(
          text: "اخصائي تربوي للاطفال",
          imagePath: "assets/images/Frame2_of_specialists.png",
        ),
        SpecialistCard(
          text: "اخصائي مشاكل اسرية",
          imagePath: "assets/images/Frame3_of_specialists.png",
        ),
        SpecialistCard(
          text: "مشورة سرية",
          imagePath: "assets/images/Frame4_of_specialists.png",
        ),
        SpecialistCard(
          text: "اخصائي ADHD",
          imagePath: "assets/images/Frame5_of_specialists.png",
        ),
        SpecialistCard(
          text: "اخصائي التوحد",
          imagePath: "assets/images/Frame6_of_specialists.png",
        ),
      ],
    );
  }
}
