import 'package:flutter/material.dart';
import 'package:lavender/core/themes/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int itemCount;      
  final int currentIndex;   
  final Color activeColor;
  final Color inactiveColor;

  const DotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.activeColor = AppColors.button,
    this.inactiveColor = AppColors.inActiveDateColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return Container(
          width: 8,
          height: 9,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            shape: BoxShape.circle,
          ),
        );
      }),
);
}
}