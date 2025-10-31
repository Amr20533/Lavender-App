import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';

class UserInfoProfile extends StatelessWidget {
  const UserInfoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserStates>(
      builder: (context, state) {
        if (state is CurrentUserProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (state is CurrentUserProfileLoaded) {
          final user = state.currentUserInfoResponse.profile.user;
          final profile = state.currentUserInfoResponse.profile.profilePic;
          final name = "${user.firstName} ${user.lastName}".trim();

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: AppColors.circleGradient,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CustomCachedNetworkImage(
                    imageUrl: "${ApiConstants.imagePath}$profile",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AlexText(
                text: name,
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.end,
              ),
            ],
          );
        } else if (state is CurrentUserProfileError) {
          return const Text(
            "Error loading user",
            style: TextStyle(color: Colors.white),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
