import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/home/presenation/widgets/specialists_card.dart';

class SpecialistsScreen extends StatelessWidget {
  const SpecialistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.w,
        title: Text("الاختصاص"),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.purple500),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: SingleChildScrollView(
          
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              SpecialistCard(
                text: "اخصائي نفسي",
                imagePath: "assets/images/Frame 1597881946 (3).png",
                height: 170.h,
                width: 170.w,
              ),
               SpecialistCard(
                text: "اخصائي تربوي للاطفال",
                imagePath: "assets/images/Frame 1597881945 (4).png",
                height: 170.h,
                width: 170.w,
              ),
               SpecialistCard(
                text: "اخصائي مشاكل اسرية",
                imagePath: "assets/images/Frame 1597881979.png",
               height: 170.h,
                width: 170.w,
              ),
               SpecialistCard(
                text: "مشورة سرية",
                imagePath: "assets/images/Frame 1597881978.png",
                height: 170.h,
                width: 170.w,
              ),
               SpecialistCard(
                text: "اخصائي ADHD",
                imagePath: "assets/images/Frame 1597881981.png",
                height: 170.h,
                width: 170.w,
              ),
                SpecialistCard(
                text: "اخصائي التوحد",
                imagePath: "assets/images/Frame 1597881980.png",
                height: 170.h,
                width: 170.w,
              ), 
                SpecialistCard(
                text: "اخصائي ADHD",
                imagePath: "assets/images/Frame 1597881981.png",
                height: 170.h,
                width: 170.w,
              ),
                SpecialistCard(
                text: "اخصائي التوحد",
                imagePath: "assets/images/Frame 1597881980.png",
                height: 170.h,
                width: 170.w,
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
