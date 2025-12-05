import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';

class AddStoryCircle extends StatelessWidget {
  final VoidCallback onTap;

  const AddStoryCircle({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Stack(
              children: [
                BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                    builder: (context, state) {
                      if (state is CurrentUserProfileLoading) {
                        return CircularProgressIndicator(color: Colors.white,);
                      }else if (state is CurrentUserProfileLoaded) {
                        final profile = state.currentUserInfoResponse.profile.profilePic;

                        return Container(
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
                        );

                      } else if (state is CurrentUserProfileError) {
                        return Text("Error loading user");
                      }
                      return SizedBox.shrink();
                    }
                ),
                // Container(
                //   width: 70,
                //   height: 70,
                //   padding: EdgeInsets.all(3),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     gradient: AppColors.circleGradient,
                //   ),
                //   child: ClipOval(
                //     child: profileImage != null && profileImage!.isNotEmpty
                //         ? CustomCachedNetworkImage(
                //       imageUrl: "${ApiConstants.imagePath}$profileImage",
                //       fit: BoxFit.cover,
                //     )
                //         : Container(
                //       color: Colors.grey[300],
                //       child: Icon(Icons.person,
                //           size: 35, color: Colors.grey[600]),
                //     ),
                //   ),
                // ),

                // ADD BUTTON
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'أنا',
              style: TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
