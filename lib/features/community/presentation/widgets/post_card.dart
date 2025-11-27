import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/presentation/cubit/community_cubit.dart';
import 'package:lavender/features/profile/data/models/user.dart';
import 'package:lavender/features/profile/data/models/user_with_profile.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_states.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.dividerColor,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileCubit, ProfileStates>(
              builder: (context, state) {
                String userName = "مستخدم غير معروف";
                String? profilePic;

                if (state is ProfileLoaded) {
                  final users = state.usersResponse.users;

                  // Try to find the user who owns this post
                  final user = users.firstWhere(
                        (u) => u.user.id == post.user,
                    orElse: () => UserWithProfile(
                      user: User(id: 0, firstName: 'مستخدم', lastName: 'غير معروف', email: ''),
                      profilePic: '',
                    ),
                  );

                  userName = "${user.user.firstName} ${user.user.lastName}".trim();
                  profilePic = user.profilePic?.isNotEmpty == true ? user.profilePic : null;
                }

                return Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorLavenderLangAndText,
                      shape: BoxShape.circle
                    ),
                    child: CustomCachedNetworkImage(imageUrl: "${ApiConstants.imagePath}$profilePic"),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlexText(
                        text: userName,
                        color: Colors.black,
                      ),
                      AlexText(
                        text: timeago.format(post.createdAt),
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.more_vert_sharp,
                      color: AppColors.primaryColorLavenderLangAndText,
                      size: 30),
                ],
              );
            }
          ),
          SizedBox(height: 12.h),
          AlexText(
            text: post.caption,
            color: Colors.black,
            fontSize: 12,
          ),
          SizedBox(height: 8.h),
          if (post.image != null) ...[
            CustomCachedNetworkImage(
              width: double.infinity,
              height: 260.h,
              imageUrl: post.image!,
            ),
            SizedBox(height: 8.h),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                      builder: (context, userState){
                        if(userState is CurrentUserProfileLoaded){
                          final currentUserId = userState.currentUserInfoResponse.profile.user.id;

                          return GestureDetector(
                          onTap: () {
                          context.read<PostsCubit>().toggleLike(post.id, currentUserId);
                          },
                          child: Image.asset(
                          post.isLiked == true
                          ? 'assets/icons/heart_filled.png' // ❤️ if liked
                              : 'assets/icons/heart.png', // 🤍 if not liked
                          width: 24.w,
                          height: 24.w,
                          color: post.isLiked == true
                          ? Colors.red
                              : AppColors.primaryColorLavenderLangAndText,
                          ),
                          );
                        }
                        return const SizedBox.shrink();
                  }),

                  SizedBox(width: 5.w),
                  AlexText(
                    text: "${post.likesCount} اعجاب",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.commentScreen, arguments: post);
                },
                child: Row(
                  children: [
                    Image.asset('assets/icons/message-notif.png'),
                    SizedBox(width: 5.w),
                    AlexText(
                      text: "${post.comments.length} تعليق",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset('assets/icons/send-2.png'),
                  SizedBox(width: 5.w),
                  AlexText(
                    text: "مشاركة",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
