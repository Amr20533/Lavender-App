import 'package:flutter/material.dart';

class AppColors {
  //(Primary Colors)
  static const Color primaryColorLavenderText = Color(0xFF45448A);
  static const Color primaryColorDarkText = Color(0xFF2B2B2B);
  static const Color primaryColorLavenderTextBouttom = Color(0XFFFFFFFF);
  static const Color primaryColorLavenderLangAndText = Color(0XFF7270E4);
  static const Color w = Color(0XFFFFFFFF);
  // (colors all app)
  static const Color grey100 = Color(0xFFF5EFFB);
  static const Color grey200 = Color(0xFFD6D7EC);
  static const Color purple50 =  Color(0xFFF2F2FF);
  static const Color dividerColor =  Color(0xFFF6F6FF);
  static const Color purpleappbar =  Color(0xFFEDEEFF);
  static const Color purple100 = Color(0xFFD7D6FD);
  static const Color purple200 = Color(0xFFC3C2FD);
  static const Color purple300 = Color(0xFFA8A7FC);
  static const Color purple400 = Color(0xFF9795FB);
  static const Color purple500 = Color(0xFF7D7BFA);
  static const Color purple600 = Color(0XFF45448A);
  static const Color purple700 = Color(0xFF5957D2);
  static const Color purple800 = Color(0xFF4548AB);
  static const Color purple900 = Color(0xFF353469);
  static const Color button =Color(0XFF7270E4);
  static const Color green1    = Color(0XFF3BC98B);
  static const Color green2    = Color(0XFF00FF90);
  static const Color green3    = Color(0XFF29CC6A);
  static const Color orang     = Color(0XFFFFBFA8);
  static const Color orang2    = Color(0XFFFF7442);
  static const Color read      = Color(0xFFFC5555);
  static const Color yellow    = Color(0xFFFFC258);
  static const Color lightYellow = Color(0xFFE8EA9D);
  static const Color pinkShade   = Color(0xFFEFB7D3);
  static const Color purpleShade = Color(0xFF8381F6);
  static const Color grey      = Color(0xFF767884);
  static const Color grey2     = Color(0xFFD9D9D9);
  static const Color grey3     = Color(0xFFFAFAFC);
  static const Color grey4     = Color(0xFFD9D9D9);

  static const Color doctorCardColor     = Color(0xFFFAFAFC);
  static const Color inactiveBorderColor     = Color(0xFFF0F4FC);
  static const Color inActiveDateColor = Color(0xFF8A96BC);
  static const Color shadePurpleColor = Color(0xFFDCDCF9);
  static Color shadowColor = Color(0xFF000000).withValues(alpha: 0.04);


  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColorLavenderLangAndText,
      purple200,
    ],
    stops: [0.0, 1.0],
  );


  static const LinearGradient circleGradient = LinearGradient(
    colors: [
      Color(0xFFEFB7D3),
      Color(0xFF8381F6),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 1.0],
  );

    static const Gradient cardGradient = LinearGradient(
    colors: [
      Color(0xFFF1F6F9), // رمادي فاتح جدًا
      Color(0xFFFFFFFF), // أبيض
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
 
 static const LinearGradient softRedCardGradient = LinearGradient(
  colors: [
   Color(0xFFF1F6F9), 
    Color.fromARGB(150, 255, 208, 209), 
    
  ],
  begin: Alignment.centerLeft,
  end: Alignment.bottomCenter,
  stops: [0.0, 1.2],
);

}
