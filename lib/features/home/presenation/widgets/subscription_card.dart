import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.purple50,
            borderRadius: BorderRadius.circular(15),
          ),

          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AlexText(
                        text: "احصل علي دعم كامل لرحلتك في\n الباقة السنوية",
                        fontSize: 12,
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          AlexText(
                            text: "اشترك الان",
                            color: AppColors.purple900,
                          ),
                          const Icon(Icons.arrow_forward_rounded, color: AppColors.purple900,),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Spacer(),
              Image.asset(
                "assets/images/Frame 1597881905 (1).png",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
