import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/menu_view.dart';
import 'package:lavender/features/home/presenation/cubit/menu_cubit.dart';

class ZoomMenuLayout extends StatelessWidget {
  const ZoomMenuLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, int>(
      builder: (context, state) {
        final bool isRtl = Directionality.of(context) == TextDirection.rtl;

        return ZoomDrawer(
          controller: context.read<MenuCubit>().zoomDrawerController,
          menuScreen: const MenuView(),
          mainScreen: context.watch<MenuCubit>().menuScreens[state],

          // RTL configuration
          isRtl: isRtl,

          angle: 0,
          borderRadius: 12,
          slideWidth: 295.0,
          menuBackgroundColor: AppColors.primaryColorLavenderLangAndText,
          mainScreenTapClose: true,
          shadowLayer1Color: Colors.transparent,
          shadowLayer2Color: AppColors.purple200,
          showShadow: true,
        );
      },
    );
  }
}
