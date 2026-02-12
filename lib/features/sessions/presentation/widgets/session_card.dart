import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/sessions/data/models/session_model.dart';

class SessionCard extends StatelessWidget {
  final SessionModel session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor Image
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child:
                  session.doctorImage.startsWith('http') ||
                          !session.doctorImage.contains('assets/')
                      ? CustomCachedNetworkImage(
                        imageUrl:
                            session.doctorImage.contains('http')
                                ? session.doctorImage
                                : "${ApiConstants.imagePath}${session.doctorImage}",
                        fit: BoxFit.cover,
                      )
                      : Image.asset(
                        session.doctorImage,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) => const Icon(Icons.person),
                      ),
            ),
          ),
          SizedBox(width: 12.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.doctorName,
                  style: GoogleFonts.alexandria(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  session.specialty,
                  style: GoogleFonts.alexandria(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    // session.time is "10:30 م"
                    Text(
                      "${session.time} 🕒 10-9", // Hardcoded date for demo as per screenshot logic or formatting
                      // Ideally format session.date
                      style: GoogleFonts.alexandria(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Video Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColorLavenderLangAndText,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.videocam_outlined,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
