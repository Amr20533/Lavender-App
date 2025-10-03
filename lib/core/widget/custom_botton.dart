import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/themes/padding.dart';
import 'package:lavender/core/themes/stylesdart.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Border? border;
  final Color textColor;
  final double? width;
  final double? height;

  const CustomButton({super.key,
    this.width = 343,
    this.height = 48,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.shadowColor,
    this.border,
    this.textColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.horizontal16 + AppPadding.all8,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 151, 149, 245),
            shadowColor: shadowColor ?? Colors.transparent,
            // side:
            // border?.top ??
            //     BorderSide(color: AppColors.purple600, width: 0.4),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(22),
            // ),
          ),
          child: Text(
            text,
            style: TextStyles.bodyMedium.copyWith(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
