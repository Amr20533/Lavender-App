import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/data/models/row_item.dart';

class DailyEmotion extends StatefulWidget {
  const DailyEmotion({super.key});

  @override
  _DailyEmotionState createState() => _DailyEmotionState();
}

class _DailyEmotionState extends State<DailyEmotion> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          RowItem.rowItems.length,
              (index) {
            final rowItem = RowItem.rowItems[index];
            final bool isSelected = (index == _selectedIndex);
      
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedIndex == index) {
                    _selectedIndex = -1;
                  } else {
                    _selectedIndex = index;
                  }
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    rowItem.icon,
                  ),
                  SizedBox(height: 8),
                  AlexText(
                    text: rowItem.title,
                    color: Colors.black,
                    fontSize: 10.sp,
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: !isSelected ? AppColors.primaryColorLavenderLangAndText : AppColors.purple100,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primaryColorLavenderLangAndText
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
