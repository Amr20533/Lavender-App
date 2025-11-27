import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_states.dart';
import 'package:lavender/features/programs/presentation/widgets/course_card_shimer.dart';
import 'package:lavender/features/programs/presentation/widgets/courses_card.dart';
import 'package:lavender/features/programs/presentation/widgets/daily_emotion.dart';
import 'package:lavender/features/programs/presentation/widgets/tool_card.dart';
import '../../home/presenation/widgets/view_all_row.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AlexText(text: "البرامج"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarShadow(),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 16.h,
                bottom: 12.h,
                start: 20,
              ),
              child: AlexText(text: "كيف حالك اليوم !"),
            ),
            DailyEmotion(),

            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 24.h,
                bottom: 12.h,
                start: 20,
              ),
              child: AlexText(text: "ادوات"),
            ),

            Padding(
              padding: EdgeInsetsDirectional.only(start: 18),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  ToolCard(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.musicScreen);
                    },
                    text: "الموسيقى",
                    imagePath: "assets/images/الموسيقى.png",
                  ),
                  ToolCard(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.measurementScreen);
                    },
                    text: "المقاييس",
                    imagePath: "assets/images/measure.png",
                  ),

                  ToolCard(text: "الهدف", imagePath: "assets/images/الهدف.png"),
                  ToolCard(
                    text: "تسجيل اليوميات",
                    imagePath: "assets/images/اليوميات.png",
                  ),
                ],
              ),
            ),
            ViewAllRow(title: "كورسات عمليه", onTap: () {}),

            BlocBuilder<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state is CoursesLoading) {
                  return SizedBox(
                    height: 290.h,
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(
                        top: 16.h,
                        bottom: 12.h,
                        start: 20,
                        end: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (context, index) => SizedBox(width: 15.w),
                      itemBuilder: (context, index) {

                        return CourseCardShimmer();
                      },
                    ),
                  );
                } else if (state is CoursesLoaded) {
                  final courses = state.courses;

                  return SizedBox(
                    height: 290.h,
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(
                        top: 16.h,
                        bottom: 12.h,
                        start: 20,
                        end: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: courses.length,
                      separatorBuilder: (context, index) => SizedBox(width: 15.w),
                      itemBuilder: (context, index) {
                        final course = courses[index];

                        return CoursesCard(
                          onTap: ()=> Navigator.pushNamed(context, Routes.courseOne),
                          course: course,
                        );
                      },
                    ),
                  );
                } else if (state is CoursesError) {
                  debugPrint('Error: ${state.message}');
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}