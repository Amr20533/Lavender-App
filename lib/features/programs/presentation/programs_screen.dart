import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/features/home/widgets/alex_text.dart';
import 'package:lavender/features/programs/presentation/widgets/tool_card.dart';
import 'package:lavender/l10n/app_localizations.dart';

import '../../../core/themes/app_colors.dart';
import '../../home/widgets/view_all_row.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlexText(text: "ادوات"),


          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              ToolCard(
                onTap: (){
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
          ViewAllRow(
            title:
            AppLocalizations.of(context)?.start_your_journey ??
                "كورسات عمليه",
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.allDoctorsScreen,
              );
            },
          ),
        ],
      ),
    );
  }
}

