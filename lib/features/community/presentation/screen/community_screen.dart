import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/community/presentation/cubit/community_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';
import 'package:lavender/features/community/presentation/cubit/create_post_cubit.dart';
import 'package:lavender/features/community/presentation/widgets/community_app_bar.dart';
import 'package:lavender/features/community/presentation/widgets/post_card.dart';
import 'package:lavender/features/community/presentation/screen/stories_bar.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';

import '../cubit/create_post_states.dart' show AddPostLoading, CreatePostStates;


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CommunityAppBar(),
          ),

          SliverToBoxAdapter(
            child: StoriesBar(),
          ),

          // Wrap your plain widget/text in SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: AlexText(text: "بوستات"),
            ),
          ),

          BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              } else if (state is PostsLoaded) {
                final posts = state.postResponse.data;

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final post = posts[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PostCard(post: post),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                      childCount: posts.length,
                    ),
                  ),
                );
              } else if (state is PostsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("Error: ${state.message}"),
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),

          // Optionally, add a bottom padding so the last item isn't cut off
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.8),
            builder: (_) {
              return AddPostDialog();
            },
          );
        },
      backgroundColor: AppColors.primaryColorLavenderLangAndText,
        shape: CircleBorder(
            side: BorderSide(color: Colors.white, width: 4)
        ),
      child: Icon(Icons.add, color: Colors.white, size: 25,),
      ),
    );
  }
}

class AddPostDialog extends StatelessWidget {
  const AddPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.1),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 14,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                builder: (context, state) {
                  if (state is CurrentUserProfileLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CurrentUserProfileLoaded) {
                    final user = state.currentUserInfoResponse.profile.user;
                    final profile = state.currentUserInfoResponse.profile.profilePic;
                    final name = "${user.firstName} ${user.lastName}".trim();

                    return Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: AppColors.circleGradient,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CustomCachedNetworkImage(
                              imageUrl: "${ApiConstants.imagePath}$profile",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        AlexText(
                          text: name,
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    );
                  } else {
                    return const Text("Error loading user");
                  }
                },
              ),


              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  controller: context.read<CreatePostCubit>().captionController,
                  maxLines: 5,
                  minLines: 3,
                  decoration: const InputDecoration(
                    hintText: "عبر عن شعورك...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              Divider(
                color: AppColors.secondDividerColor,
                height: 1,
              ),

              BlocBuilder<CreatePostCubit, CreatePostStates>(
                builder: (context, state) {
                  final isLoading = state is AddPostLoading;

                  if (isLoading) {
                    return Center(
                        child: SizedBox(
                        height: 28,
                        width: 28,
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColorLavenderLangAndText,
                        strokeWidth: 2,
                      ),
                    ),
                      );
                  } else {
                    return CustomButton(
                    onPressed: () async {
                      if(context.read<CreatePostCubit>().captionController.text.isNotEmpty){
                        final newPost = await context.read<CreatePostCubit>().createPost();
                        if (newPost != null) {
                          context.read<PostsCubit>().addPostToList(newPost);
                          Navigator.pop(context);
                        }else{
                          debugPrint("Add a caption!");
                        }

                      }
                    },
                    width: double.infinity,
                    text: "نشر",
                  );
                  }
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}




