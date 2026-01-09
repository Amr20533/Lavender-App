import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/exception_view.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_states.dart';
import 'package:lavender/features/programs/presentation/widgets/daily_emotion.dart';
import 'package:lavender/features/programs/presentation/widgets/program_card.dart';
import 'package:lavender/features/programs/presentation/widgets/program_card_shimmer.dart';
import 'package:lavender/features/programs/presentation/widgets/tool_card.dart';

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

      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        slivers: [
          /// App bar shadow
          SliverToBoxAdapter(
            child: AppBarShadow(),
          ),

          /// Greeting
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 16.h,
                bottom: 12.h,
                start: 20,
              ),
              child: AlexText(text: "كيف حالك اليوم !"),
            ),
          ),

          /// Daily Emotion
          SliverToBoxAdapter(
            child: DailyEmotion(),
          ),

          /// Tools title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 24.h,
                bottom: 12.h,
                start: 20,
              ),
              child: AlexText(text: "ادوات"),
            ),
          ),

          /// Tools grid (Wrap)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                mainAxisExtent: 72.h,
              ),
              delegate: SliverChildListDelegate(
                [
                  ToolCard(
                    onTap: () => Navigator.pushNamed(context, Routes.musicScreen),
                    text: "الموسيقى",
                    imagePath: "assets/images/الموسيقى.png",
                    width: double.infinity, // Let the grid determine the width
                  ),
                  ToolCard(
                    onTap: () => Navigator.pushNamed(context, Routes.measurementScreen),
                    text: "المقاييس",
                    imagePath: "assets/images/measure.png",
                    width: double.infinity,
                  ),
                  ToolCard(
                    onTap: () => Navigator.pushNamed(context, Routes.exercisesAndActivities),
                    text: "الانشطة والتمارين",
                    imagePath: "assets/images/الهدف.png",
                    width: double.infinity,
                  ),
                  ToolCard(
                    text: "تسجيل اليوميات",
                    imagePath: "assets/images/اليوميات.png",
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          /// View all row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10, start: 16),
              child: AlexText(text: "برامج مجانية"),
            ),
          ),

          /// Programs list
          BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              if (state is ProgramLoading) {
                return SliverToBoxAdapter(
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.only(
                      top: 16.h,
                      bottom: 12.h,
                      start: 20,
                      end: 20,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(height: 15.w),
                    itemBuilder: (_, __) => ProgramCardShimmer(),
                  ),
                );
              }

              if (state is ProgramLoaded) {
                return SliverList.separated(
                  itemCount: state.programs.length,
                  separatorBuilder: (_, __) => SizedBox(height: 15.h),
                  itemBuilder: (context, index) {
                    final program = state.programs[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                      ),
                      child: ProgramCard(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.courseOne,
                        ),
                        program: program,
                      ),
                    );
                  },
                );
              }

              if (state is ProgramError) {
                return SliverToBoxAdapter(
                  child: ExceptionView(
                    onPressed: (){
                      context.read<CoursesCubit>().fetchFreePrograms();
                    },
                    message: state.message),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          /// Bottom spacing
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
        ],
      ),
    );
  }
}

