import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure request uses svg or icon
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'package:lavender/features/sessions/logic/cubit/sessions_cubit.dart';
import 'package:lavender/features/sessions/logic/cubit/sessions_state.dart';
import 'package:lavender/features/sessions/presentation/widgets/group_session_card.dart';
import 'package:lavender/features/sessions/presentation/widgets/session_card.dart';

class SessionsView extends StatelessWidget {
  const SessionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (context) => SessionsCubit()..loadSessions(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.primaryColorLavenderLangAndText),
            onPressed: () {},
          ),
          
          actions: [
            
            Padding(
               padding: EdgeInsets.only(left: 16.w), 
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.editProfileScreen);
                },
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300, // Placeholder background
                  ),
                  child: BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                    builder: (context, state) {
                      if (state is CurrentUserProfileLoaded) {
                        final profile = state.currentUserInfoResponse.profile.profilePic;
                        return CustomCachedNetworkImage(
                          imageUrl: "${ApiConstants.imagePath}$profile",
                          fit: BoxFit.fill,
                        );
                      }
                      return const Icon(Icons.person, color: Colors.white); // Placeholder icon
                    },
                  ),
                ),),
             
            )
          ],
          title: Center(
            child: Text(
              "الجلسات",
              style: GoogleFonts.alexandria(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColorLavenderLangAndText,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // Search Bar
                TextField(
                  textAlign: TextAlign.right, // RTL
                  decoration: InputDecoration(
                    hintText: "ابحث عن استشاري...",
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColorLavenderLangAndText),
                    suffixIcon: const Icon(Icons.tune, color: AppColors.primaryColorLavenderLangAndText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColors.primaryColorLavenderLangAndText),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColors.primaryColorLavenderLangAndText),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w)
                  ),
                ),
                SizedBox(height: 20.h),

                // Filters
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterTab("تم الالغاء", false),
                    _buildFilterTab("تم الاجتماع", false),
                    _buildFilterTab("القادم", true),
                  ],
                ),
                SizedBox(height: 20.h),

                 // Date Strip (Static for demo)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(7, (index) {
                      bool isSelected = index == 3; // "9 Today"
                      final days = ["السبت", "الاحد", "الاثنين", "اليوم", "الاربعاء", "خميس", "جمعة"];
                      final dates = ["6", "7", "8", "9", "10", "11", "12"];
                      return Container(
                        margin: EdgeInsets.only(left: 8.w),
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: isSelected ? AppColors.primaryColorLavenderLangAndText : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                              Text(dates[index], style: GoogleFonts.alexandria(fontWeight: FontWeight.bold, fontSize: 16.sp, color: isSelected ? AppColors.primaryColorLavenderLangAndText : Colors.black)),
                              Text(days[index], style: GoogleFonts.alexandria(fontSize: 12.sp, color: Colors.grey)),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20.h),

                // Upcoming Sessions Header
                Text(
                  "الجلسات القادمة",
                  style: GoogleFonts.alexandria(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorLavenderLangAndText,
                  ),
                ),
                Text(
                  "اليوم (9-10)",
                  style: GoogleFonts.alexandria(
                    fontSize: 12.sp,
                     color: Colors.black,
                     fontWeight: FontWeight.bold
                  ),
                ),
                 SizedBox(height: 12.h),

                // Upcoming List
                BlocBuilder<SessionsCubit, SessionsState>(
                  builder: (context, state) {
                    if (state is SessionsLoaded) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.upcomingSessions.length,
                        separatorBuilder: (c, i) => SizedBox(height : 12.h),
                        itemBuilder: (context, index) {
                          return SessionCard(session: state.upcomingSessions[index]);
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                
                 SizedBox(height: 20.h),
                 // Group Sessions Header
                 Text(
                  "جلسات جماعية اون لاين",
                  style: GoogleFonts.alexandria(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorLavenderLangAndText,
                  ),
                ),
                SizedBox(height: 12.h),

                // Group List
                 BlocBuilder<SessionsCubit, SessionsState>(
                  builder: (context, state) {
                    if (state is SessionsLoaded) {
                      return SizedBox(
                        height: 280.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.groupSessions.length,
                          itemBuilder: (context, index) {
                            return GroupSessionCard(session: state.groupSessions[index]);
                          },
                        ),
                      );
                    }
                     return const SizedBox.shrink();
                  },
                ),
                 SizedBox(height: 100.h), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppColors.grey3, // Very light grey for unselected
          border: isSelected ? Border.all(color: AppColors.primaryColorLavenderLangAndText) : null,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.alexandria(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primaryColorLavenderLangAndText : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
