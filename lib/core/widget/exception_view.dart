import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/core/widget/get_error_icon.dart';

class ExceptionView extends StatelessWidget {
  const ExceptionView({
    super.key, required this.onPressed, required this.message,
  });
  final void Function() onPressed;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                getErrorIconFromMessage(message),
                size: 36,
                color: AppColors.primaryColorLavenderLangAndText,
              ),
            ),

            const SizedBox(height: 16),

            // Error message
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.lightBlack,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            CustomButton(
              width: 150,
              onPressed: onPressed,
              text: "Refresh",
            ),
          ],
        ),
      ),
    );
  }
}