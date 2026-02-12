import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
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
              alignment: Alignment.center,
              children: [
                BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                    builder: (context, state) {
                      if (state is CurrentUserProfileLoading) {
                        return CircularProgressIndicator(color: Colors.white,);
                      }else if (state is CurrentUserProfileLoaded) {
                        final profile = state.currentUserInfoResponse.profile.profilePic;

                        return Container(
                          width: 55,
                          height: 55,
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
                Image.asset("assets/icons/add.png"),
              ],
            ),
            SizedBox(height: 5),
            AlexText(text: 'أنا', color: Colors.black,fontSize:  12,fontWeight: FontWeight.normal,),
          ],
        ),
      ),
    );
  }
}
