import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/features/home/presenation/widgets/specialists_card.dart';

class TripCards extends StatelessWidget {
  const TripCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        shrinkWrap: true, // Crucial if inside a Column or ListView
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 176 / 120, // Matches your width/height ratio
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
      ),
    );
  }
}
