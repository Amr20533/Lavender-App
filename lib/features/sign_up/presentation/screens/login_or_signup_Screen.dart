import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_botton.dart';

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/iPhone 13 mini.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset("assets/svg/logo_text_lavender.svg"),
                  ),
                  SizedBox(height: 25.h),
                  Image.asset("assets/images/image_singup.png"),
                  SizedBox(height: 20.h),
                  Text(
                    "اكتشف رحلة بداخل ذاتك و طرق الحلول",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple500,
                    ),
                  ),
                  Text(
                    "لكل مشاكلك",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple500,
                    ),
                  ),
                 SizedBox(height: 30.h,),
                  CustomButton(
                    text: "تسجيل الدخول",
                    textColor: AppColors.primaryColorLavenderTextBouttom,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signInScreen);
                    },
                  ),
                  CustomButton(
                    text: "انشاء حساب جديد",
                    textColor: AppColors.button,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.);
                       Navigator.pushNamed(context, Routes.signUpScreen);
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                    onPressed: () {
                       Navigator.pushNamed(context, Routes.homeScreen);
                    },
                    child: Text(
                      " الدخول ك ضيف",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryColorDarkText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
