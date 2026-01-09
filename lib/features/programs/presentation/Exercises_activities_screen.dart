import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/presentation/widgets/activities_view.dart';
import 'package:lavender/features/programs/presentation/widgets/exercises_view.dart';

import '../../../core/themes/app_colors.dart';

class ExercisesActivitiesScreen extends StatelessWidget {
  const ExercisesActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: AlexText(text: "الأنشطة والتمارين", ),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          leading: BackIcon(),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.doctorCardColor,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.button,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.primaryColorDarkText,
                    padding: EdgeInsets.all(4),
                    labelStyle: GoogleFonts.alexandria(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: GoogleFonts.alexandria(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: const [
                      Tab(text: "الأنشطة"),

                      Tab(text: "التمارين"),
                    ],
                  ),
                ),

                // Tab Bar View (Switcher)
                const Expanded(
                  child: TabBarView(
                    children: [
                      ActivitiesView(),

                      ExercisesView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

