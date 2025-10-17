import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      right: 13,
      left: 13,
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, Routes.searchScreen);
        },
        child: Container(
          width: double.infinity,
          height: 52.h,
          padding: EdgeInsetsDirectional.only(start: 16, end: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(50.sp),
          ),
          child: Row(
            spacing: 12,
            children: [
              Image.asset('assets/icons/search.png', color: Colors.white,),
              AlexText(text: "Search", color: Colors.white,),
              const Spacer(),
              Image.asset('assets/icons/filter.png')
            ],
          ),
        ),
      ),
    );
  }
}
