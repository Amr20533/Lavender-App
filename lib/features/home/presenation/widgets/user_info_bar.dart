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

class UserInfoBar extends StatelessWidget {
  const UserInfoBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 60,
      ),
      child: BlocBuilder<CurrentUserCubit, CurrentUserStates>(
          builder: (context, state) {
            if (state is CurrentUserProfileLoading) {
              return CircularProgressIndicator(color: Colors.white,);
            }else if (state is CurrentUserProfileLoaded) {
              final user = state.currentUserInfoResponse.profile.user;
              final profile = state.currentUserInfoResponse.profile.profilePic;
              final name = "${user.firstName} ${user.lastName}".trim();

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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


                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3.h,
                    children: [
                      AlexText(text: "صباح الخير", color: Colors.white, fontSize: 12,),
                      AlexText(text: name, color: Colors.white,),
                    ],
                  ),
                  Spacer(),
                  CircularIcon(icon: "shopping-cart.png"),
                  CircularIcon(icon: "notification.png"),
                ],
              );

            } else if (state is CurrentUserProfileError) {
              return Text("Error loading user");
            }
            return SizedBox.shrink();
          }
      ),
    );
  }
}