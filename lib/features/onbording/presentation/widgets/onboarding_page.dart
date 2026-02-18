import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/onbording/data/models/onboarding_model.dart';
import 'package:lavender/features/onbording/presentation/widgets/circular_progress_indicator.dart';
import 'package:lavender/features/onbording/presentation/widgets/top_curve_.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final int currentPage;
  final VoidCallback onNext;

  const OnboardingPage({
    super.key,
    required this.model,
    required this.currentPage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purpleappbar,
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Image.asset(
              model.imagePath,
              width: double.infinity,
             // height: MediaQuery.of(context).size.height * 0.6,
              height: 436.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: GestureDetector(
              onTap: () {
              //  final box = Hive.box('appBox');
                //box.put('onboardingCompleted', true);
               Navigator.pushReplacementNamed(context, Routes.loginOrSignupScreen);
              },
              child: Text(
                "skip".tr(),
                style: TextStyle(
                  color: AppColors.purple600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: double.infinity,
                color: AppColors.w,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index
                                ?AppColors.purple300
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 111, 109, 202),
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      model.subtitle,
                      style: TextStyle(
                        color: AppColors.purple900,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CircularProgressIndicatorWidget(
                      progress: model.progress,
                      onNext: onNext, totalSegments: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
     ),
);
}
}