import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/presentation/widgets/daily_emotion.dart';
import 'package:lavender/features/programs/presentation/widgets/tool_card.dart';
import 'package:lavender/l10n/app_localizations.dart';
import '../../home/widgets/view_all_row.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AlexText(text: "البرامج"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarShadow(),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 12.h, start: 20),
            child: AlexText(text: "كيف حالك اليوم !"),
          ),
          DailyEmotion(),

          Padding(
            padding: EdgeInsetsDirectional.only(top: 24.h, bottom: 12.h, start: 20),
            child: AlexText(text: "ادوات"),
          ),


          Padding(
            padding: EdgeInsetsDirectional.only(start: 18),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                ToolCard(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.musicScreen);
                  },
                  text: "الموسيقى",
                  imagePath: "assets/images/الموسيقى.png",
                ),
                ToolCard(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.measurementScreen);
                  },
                  text: "المقاييس",
                  imagePath: "assets/images/measure.png",
                ),
                ToolCard(
                  text: "الهدف",
                  imagePath: "assets/images/الهدف.png",
                ),
                ToolCard(
                  text: "تسجيل اليوميات",
                  imagePath: "assets/images/اليوميات.png",
                ),
              ],
            ),
          ),
          ViewAllRow(
            title: "كورسات عمليه",
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}


