import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const BackIcon({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 3, 0, 3),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              color: AppColors.purple50,
              shape: BoxShape.circle
          ) ,
          child: Image.asset('assets/icons/arrow-right.png'),
          // child: Icon(Icons.arrow_back_sharp, color: AppColors.primaryColorLavenderLangAndText,size: 25,),
        ),
      ),
    );
  }
}
