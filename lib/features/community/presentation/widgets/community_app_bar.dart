import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/circularIcon.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import '../../../../core/widget/custom_cached_network_image.dart';

class CommunityAppBar extends StatelessWidget {
  const CommunityAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsetsDirectional.only(top: 20, start: 16, end: 16,),
      decoration: BoxDecoration(
          color: Colors.white
      ),
      child:Row(
        children: [
          BlocBuilder<CurrentUserCubit, CurrentUserStates>(
              builder: (context, state) {
                            if (state is CurrentUserProfileLoading) {
              return CircularProgressIndicator(color: Colors.white,);
            }else if (state is CurrentUserProfileLoaded) {
              final user = state.currentUserInfoResponse.profile.user;
              final profile = state.currentUserInfoResponse.profile.profilePic;
              final name = "${user.firstName} ${user.lastName}".trim();

              return Container(
                width: 42,
                height: 42,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: AppColors.purple50,
                    shape: BoxShape.circle
                ),
                child: CustomCachedNetworkImage(imageUrl: "${ApiConstants.imagePath}$profile"),
              );

            } else if (state is CurrentUserProfileError) {
              return Text("Error loading user");
            }
            return SizedBox.shrink();
          }
          ),
          CircularIcon(icon: 'search.png',),
          const Spacer(),
          AlexText(text: "المجتمع"),
          const Spacer(),
          CircularIcon(icon: 'message-notif.png',),
          CircularIcon(icon: 'notification.png',),
        ],
      ),
    );
  }
}
