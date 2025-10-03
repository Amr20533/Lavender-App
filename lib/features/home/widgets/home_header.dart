import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/home/widgets/search_filter_bar.dart';
import 'package:lavender/features/home/widgets/user_info_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 214,
          decoration: BoxDecoration(
            gradient: AppColors.linearGradient,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(32),
              bottomEnd: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 190, top: 90),
            child: SvgPicture.asset("assets/svg/Meditation Icon.svg"),
          ),
        ),

        UserInfoBar(),
        SearchFilterBar(),

      ],
    );
  }
}
