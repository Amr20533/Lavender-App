import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/sessions/data/models/session_model.dart';

class GroupSessionCard extends StatelessWidget {
  final SessionModel session;

  const GroupSessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w, // Fixed width for horizontal list
      margin: EdgeInsets.only(right: 12.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Overlay
          Stack(
            children: [
              Container(
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/group_placeholder.png"), // Fallback
                     fit: BoxFit.cover,
                  ),
                ),
                 child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.asset(session.groupImage ?? "", fit: BoxFit.cover, width: double.infinity, errorBuilder: (c,o,s)=> Container(color: Colors.grey[300]),)
                ),
              ),
              // Timer overlay (Simplified mock)
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     _buildTimerItem("20", "ثانية"),
                     _buildTimerItem("24", "دقيقة"),
                     _buildTimerItem("30", "ساعة"),
                     _buildTimerItem("10", "يوم"),
                  ],
                ),
              )
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   "${session.doctorName} - ${session.specialty}",
                   style: GoogleFonts.alexandria(
                     color: AppColors.primaryColorLavenderLangAndText,
                     fontSize: 12.sp,
                     fontWeight: FontWeight.bold
                   ),
                 ),
                 SizedBox(height: 4.h),
                 Text(
                   "الموعد الأحد 29 سبتمبر | 7:00 مساء",
                   style: GoogleFonts.alexandria(
                     color: AppColors.primaryColorDarkText,
                     fontSize: 10.sp,
                   ),
                 ),
                   SizedBox(height: 4.h),
                 Text(
                   "المقاعد المتبقية  ${session.attendees} مقاعد",
                   style: GoogleFonts.alexandria(
                     color: AppColors.primaryColorLavenderLangAndText,
                     fontSize: 10.sp,
                   ),
                 ),
                 SizedBox(height: 12.h),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "${session.price?.toInt()} جنيه",
                       style: GoogleFonts.alexandria(
                         fontSize: 14.sp,
                         fontWeight: FontWeight.bold,
                         color: Colors.black87
                       ),
                     ),
                     ElevatedButton(
                       onPressed: (){}, 
                       style: ElevatedButton.styleFrom(
                         backgroundColor: AppColors.primaryColorLavenderLangAndText,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h)
                       ),
                       child: Text("سجل الان", style: GoogleFonts.alexandria(color: Colors.white, fontSize: 12.sp),)
                     )
                   ],
                 )

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimerItem(String val, String label){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Column(
        children: [
          Text(val, style: GoogleFonts.alexandria(fontWeight: FontWeight.bold, fontSize: 12.sp, color: AppColors.primaryColorLavenderLangAndText),),
          Text(label, style: GoogleFonts.alexandria(fontSize: 8.sp, color: Colors.black),),

        ],
      ),
    );
  }
}
