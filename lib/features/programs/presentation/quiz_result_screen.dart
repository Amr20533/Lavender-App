import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/inter_text.dart';

class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AlexText(text: "نتيجة القياس"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),

      body: Column(
        spacing: 24.h,
        children: [
          AppBarShadow(),

          Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 35.h),
          child: AlexText(text: "احتمالية وجود اكتئاب"),
        ),
        DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1.5,
          valueNotifier: _valueNotifier,
          progress: 34,
          startAngle: 270,
          corners: StrokeCap.square,
          foregroundColor: AppColors.primaryColorLavenderLangAndText,
          backgroundColor: AppColors.grey3,
          foregroundStrokeWidth: 36,
          backgroundStrokeWidth: 36,
          sweepAngle: 180,
          animation: true,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (_, double value, __) => Text(
                '${value.toInt()}%',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 60
                ),
              ),
            ),
          ),
        ),
        Divider(color: AppColors.dividerColor, indent: 22,endIndent: 22,height: 1.5.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: InterText(text: "نذكرك أن هذا المقياس مساعد للتشخيص المبدئي ولا يعتبر تشخيص نهائي", color: AppColors.primaryColorDarkText,fontSize: 12.sp,),
        ),
          Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: InterText(text: "لمساعدتك في تحسين صحتك النفسية والوصول للراحة التي تعيدك للحياة المستقرة.استمر في المتابعة مع الأخصائي", color: AppColors.grey, fontSize: 12.sp,),
        ),

      ],),
      bottomNavigationBar: Container(
        height: 98.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: CustomButton(
          onPressed: () {

          },
          text: "ناقش الاخصائي النتيجة الان",
        ),
      ),
    );
  }
}

