import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_icons.dart';
import 'package:lavender/core/widget/nav_tile.dart';
import 'package:lavender/core/widget/user_info_profile.dart';
import 'package:lavender/features/home/presenation/cubit/menu_cubit.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_state.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35, top: 95, left: 20),
            child: BlocBuilder<MenuCubit, int>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoProfile(),
                    NavTile(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.userInfoProfile);
                      },
                      title: "Profile",
                      icon: AppIcons.userSquare,
                    ),
                    NavTile(
                      onTap: () {},
                      title: "History",
                      icon: AppIcons.history,
                    ),
                    NavTile(
                      onTap: () {
                        context.read<MenuCubit>().selectTile(2);
                      },
                      title: "Favorites",
                      icon: AppIcons.heart,
                    ),
                    NavTile(
                      onTap: () {},
                      title: "Settings",
                      icon: AppIcons.history,
                    ),
      
                    BlocBuilder<SignInCubit, SigninState>(
                      builder: (signInContext, state) {
                        return NavTile(
                          onTap: () {
                            signInContext.read<SignInCubit>().signOut();
                            context.read<MenuCubit>().toggleDrawer();
                            Navigator.popAndPushNamed(context, Routes.loginOrSignupScreen);
                          },
                          title: "Logout",
                          icon: Icons.logout,
                        );
                      },
                    ),
                    const Spacer(flex: 1),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: List.generate(4, (index) {
                    //     return NavTile(
                    //       onTap: (){
                    //
                    //       },
                    //       title: "title",
                    //       icon: "serviceNavItems.icon",
                    //     );
                    //   }),
                    // ),
                    Center(
                      child: AlexText(
                       text:  "لافندر  إصدار 1.0.0",
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
