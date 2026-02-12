import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/circularIcon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/features/favorites/presenation/screens/favorite_screen.dart';

class UserInfoBar extends StatelessWidget {
  const UserInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
      child: BlocBuilder<CurrentUserCubit, CurrentUserStates>(
        builder: (context, state) {
          if (state is CurrentUserProfileLoading ||
              state is CurrentUserUpdateLoading) {
            return CircularProgressIndicator(color: Colors.white);
          } else if (state is CurrentUserProfileLoaded ||
              state is CurrentUserUpdateSuccess) {
            final user =
                (state is CurrentUserProfileLoaded)
                    ? state.currentUserInfoResponse.profile.user
                    : context.read<CurrentUserCubit>().state
                        is CurrentUserProfileLoaded
                    ? (context.read<CurrentUserCubit>().state
                            as CurrentUserProfileLoaded)
                        .currentUserInfoResponse
                        .profile
                        .user
                    : null; // Fallback or handle better if needed

            // Simplify: Just rely on the fact that if it WAS loaded, we might have data.
            // But strictly speaking, if state is UpdateSuccess, we don't have the data inside 'state' variable if it's not the same type.
            // So, better to just show loading during update, OR fetch the data from the cubit if it retains it.

            // Correction: CurrentUserCubit emits UpdateSuccess, which is a Change.
            // If CurrentUserStates is a sealed class, we lost the data.
            // So showing Loading is the safest quick fix.

            if (state is CurrentUserUpdateSuccess) {
              return CircularProgressIndicator(color: Colors.white);
            }

            final profile =
                (state as CurrentUserProfileLoaded)
                    .currentUserInfoResponse
                    .profile
                    .profilePic;
            final userObj = state.currentUserInfoResponse.profile.user;
            final name = "${userObj.firstName} ${userObj.lastName}".trim();

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.editProfileScreen);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: AppColors.circleGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: AppColors.circleGradient,
                        shape: BoxShape.circle,
                      ),
                      child: CustomCachedNetworkImage(
                        imageUrl: "${ApiConstants.imagePath}$profile",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3.h,
                  children: [
                    AlexText(
                      text: "صباح الخير",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    AlexText(text: name, color: Colors.white),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.purple50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      color: AppColors.primaryColorLavenderLangAndText,
                      size: 24,
                    ),
                  ),
                ),
                const CircularIcon(icon: "notification.png"),
              ],
            );
          } else if (state is CurrentUserProfileError) {
            return Text("Error loading user");
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
