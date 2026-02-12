import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/user_info_profile.dart';
import 'package:lavender/features/favorites/presenation/screens/favorite_screen.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_cubit.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),

            // User Profile Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const UserInfoProfile(),
                  const Spacer(),
                  IconButton(
                    onPressed:
                        () => Navigator.pushNamed(
                      context,
                      Routes.editProfileScreen,
                    ),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            // Menu Items
            _buildMenuItem(
              context,
              title: "الملف الشخصي",
              icon: Icons.person_outline,
              onTap:
                  () => Navigator.pushNamed(context, Routes.editProfileScreen),
            ),
            SizedBox(height: 16.h),
            _buildMenuItem(
              context,
              title: "المفضلة",
              icon: Icons.favorite_border,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            _buildMenuItem(
              context,
              title: "تسجيل الخروج",
              icon: Icons.logout,
              color: Colors.red.shade300,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            const Spacer(),
            Center(
              child: AlexText(
                text: "لافندر  إصدار 1.0.0",
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
        Color? color,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
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
            Icon(
              icon,
              color: color ?? AppColors.primaryColorLavenderLangAndText,
            ),
            SizedBox(width: 16.w),
            AlexText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color ?? Colors.black87,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: const AlexText(
          text: "تسجيل الخروج",
          fontWeight: FontWeight.bold,
        ),
        content: const AlexText(text: "هل أنت متأكد من خروجك من لافندر؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AlexText(text: "إلغاء", color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              context.read<SignInCubit>().signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.signInScreen,
                    (route) => false,
              );
            },
            child: const AlexText(text: "خروج", color: Colors.red),
          ),
        ],
      ),
    );
  }
}