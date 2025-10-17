import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/programs/data/models/doctor_basic_info.dart';
import 'package:lavender/features/programs/presentation/cubit/reviews_cubit.dart';

class ReviewsScreen extends StatelessWidget {
  final DoctorBasicInfo? doctor;

  const ReviewsScreen({super.key, this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewsCubit(),
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          final cubit = context.read<ReviewsCubit>();
          final doctor = this.doctor;

          final doctorId = doctor?.id ?? 0;

          final currentRating = cubit.getDoctorRating(doctorId);

          return Scaffold(
            appBar: AppBar(
              title: const AlexText(text: "التقييم"),
              toolbarHeight: 70,
              leading: const BackIcon(),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppBarShadow(),

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 30.h,
                      bottom: 20.h,
                      start: 20,
                    ),
                    child: const AlexText(text: "آمل أن تكون بخير الآن!"),
                  ),

                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: CustomCachedNetworkImage(
                              imageUrl:
                                  "${ApiConstants.imagePath}${doctor?.profilePic ?? ''}",
                              fit: BoxFit.cover,
                              heroTag:
                                  "doctor_${doctor?.firstName}_${doctor?.lastName}",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          doctor != null
                              ? 'د. ${doctor.firstName} ${doctor.lastName}'
                              : 'دكتور غير معروف',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (doctor?.speciality != null &&
                                  doctor!.speciality.isNotEmpty)
                              ? doctor.speciality
                              : 'تخصص غير محدد',
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  RatingBar.builder(
                    initialRating: currentRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40,
                    itemPadding:
                        const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      cubit.updateDoctorRating(doctorId, rating);
                      debugPrint(
                          "تم تقييم الدكتور ${doctor?.firstName} بـ $rating نجوم");
                    },
                  ),

                  SizedBox(height: 10.h),
                  Text(
                    "تقييمك الحالي: ${currentRating.toStringAsFixed(1)}",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
                  ),

                  SizedBox(height: 30.h),

                  ElevatedButton(
                    onPressed: () {
                      final finalRating = cubit.getDoctorRating(doctorId);
                      Navigator.pop(context, finalRating);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple400,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text(
                      'إرسال التقييم',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
