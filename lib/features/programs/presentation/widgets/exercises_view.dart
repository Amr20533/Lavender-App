import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/data/models/exercises/exercises_model.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true, // Crucial if inside a Column or ListView
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 24,bottom: 24),
      // padding: EdgeInsets.only(top: 24,bottom: 24, left: 16, right: 16),
      crossAxisCount: 2,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 176 / 120,
      children: [
        GestureDetector(
          onTap: (){
            final selectedExercise = ExerciseModel.breathingExercises[0];
            Navigator.pushNamed(
              context,
              Routes.exerciseDetails,
              arguments: selectedExercise, // Passing the Map here
            );
          },
          child: Container(
              width: 167,
              height: 132,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.doctorCardColor,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Image.asset('assets/icons/yoga-01.png'),
                  AlexText(text: 'تمرين التنفس', fontSize: 12,)
                ],
              )),
        ),
      ],
    );
  }
}

