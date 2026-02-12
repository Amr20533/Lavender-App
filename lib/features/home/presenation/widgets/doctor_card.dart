import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/themes/stylesdart.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/favorites/presenation/widgets/favorite_specialist_icon.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, this.onTap, required this.specialist});
  final void Function()? onTap;
  final Specialist specialist;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.all(12.r),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.doctorCardColor,
          borderRadius: BorderRadius.circular(16.r),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 6,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70.w,
                  width: 70.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomCachedNetworkImage(
                    imageUrl: "${ApiConstants.imagePath}${specialist.profilePic}",
                    heroTag: "specialist_${specialist.user.id}",),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${specialist.user.firstName} ${specialist.user.lastName}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FavoriteSpecialistIcon(specialist: specialist),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      Row(
                        children: [
                          SizedBox(width: 8.w),
                          Text(
                            "${specialist.avgRating}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          SizedBox(width: 2.w),
                          Text(
                            "${specialist.yearsOfExperience} سنين خبرة",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                                                ],
                      ),

                      SizedBox(height: 6.h),

                      Row(spacing: 8,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 8.sp, color: AppColors.primaryColorLavenderLangAndText),
                              SizedBox(width: 4.w),
                              AlexText(text: "20 قصة تعافي",fontSize: 12, color: Colors.black),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 8.sp, color: Colors.greenAccent.shade400),
                              SizedBox(width: 4.w),
                              AlexText(text: "85% حضور",fontSize: 12, color: Colors.black),
                            ],
                          ),

                        ],
                      ),

                      SizedBox(height: 4.h),
                      // SizedBox(height: 10.h),

                      RichText(
                        text: TextSpan(
                          // Base style for all children
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: GoogleFonts.alexandria().fontFamily,
                          ),
                          children: [
                            const TextSpan(text: "اقرب موعد: ",style: TextStyle(
                                color: AppColors.grey
                            )),
                            TextSpan(
                              text: "يوم ",
                              // text: "October 25 at 5:00 PM",
                              style: TextStyles.smallRegular.copyWith(
                                color: AppColors.playPauseBlackColor,
                                // Ensure it doesn't override the parent's font family if not needed
                              ),
                            ),
                            TextSpan(
                              text: "25-10 ",
                              style: TextStyles.smallRegular.copyWith(
                                color: AppColors.primaryColorLavenderLangAndText,
                              ),
                            ),
                            TextSpan(
                              text: "الساعة ",
                              // text: "October 25 at 5:00 PM",
                              style: TextStyles.smallRegular.copyWith(
                                color: AppColors.playPauseBlackColor,
                              ),
                            ),

                            TextSpan(
                              text: " 5:00م",
                              style: TextStyles.smallRegular.copyWith(
                                color: AppColors.primaryColorLavenderLangAndText,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),


            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {},
                    icon: Image.asset('assets/icons/glass.png'),
                    // icon: const Icon(Icons.event_available, color: Colors.white),
                    label: AlexText(
                      text: "احجز الان",
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlexText(text: "سعر الساعة", fontSize: 12,color: AppColors.grey,),
                    AlexText(text: "${_removeTrailingZeros(double.parse(specialist.pricePerHour))} جنيه", fontSize: 12,color: AppColors.primaryColorLavenderLangAndText,),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  String _removeTrailingZeros(double value) {
    // Convert to string with a high precision limit
    String str = value.toStringAsFixed(2);

    // Remove trailing zeros and then the decimal point if it's left at the end
    return str.replaceAll(RegExp(r'\.?0+$'), "");
  }
}

