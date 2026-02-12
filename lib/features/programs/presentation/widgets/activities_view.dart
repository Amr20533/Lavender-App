import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/logic/cubit/activities_cubit.dart';
import 'package:lavender/features/programs/logic/cubit/activities_state.dart';
import 'package:lavender/features/programs/data/models/activities/activity_model.dart';
import 'add_activity_bottom_sheet.dart';

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (context, state) {
          if (state is ActivitiesLoaded) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              itemCount: state.activities.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final activity = state.activities[index];
                return _buildActivityItem(context, activity);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: FloatingActionButton.extended(
          onPressed: () => _showAddActivity(context),
          label: AlexText(
            text: "اضافة نشاط +",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: AppColors.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 4,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildActivityItem(BuildContext context, ActivityModel activity) {
    final isCompleted = activity.isCompleted;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          activity.svgPath != null
              ? SvgPicture.asset(
            activity.svgPath!,
            width: 32.sp,
            height: 32.sp,
            colorFilter: ColorFilter.mode(
              isCompleted ? Colors.grey : AppColors.button,
              BlendMode.srcIn,
            ),
          )
              : Icon(
            activity.icon ?? Icons.help_outline,
            color: isCompleted ? Colors.grey : AppColors.button,
            size: 32.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AlexText(
                  text: activity.title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCompleted ? Colors.grey : Colors.black87,
                ),
                Text(
                  activity.time,
                  style: GoogleFonts.alexandria(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap:
                () =>
                context.read<ActivitiesCubit>().toggleActivity(activity.id),
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.button : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? AppColors.button : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child:
              isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddActivity(BuildContext context) {
    final activitiesCubit = context.read<ActivitiesCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => BlocProvider.value(
        value: activitiesCubit,
        child: const AddActivityBottomSheet(),
      ),
    );
  }
}