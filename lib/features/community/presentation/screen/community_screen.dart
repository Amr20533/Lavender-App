import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/exception_view.dart';
import 'package:lavender/features/community/presentation/cubit/community_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';
import 'package:lavender/features/community/presentation/cubit/create_post_cubit.dart';
import 'package:lavender/features/community/presentation/widgets/add_post_bottom_sheet.dart';
import 'package:lavender/features/community/presentation/widgets/community_app_bar.dart';
import 'package:lavender/features/community/presentation/widgets/post_card.dart';
import 'package:lavender/features/community/presentation/screen/stories_bar.dart';
import 'package:lavender/features/community/presentation/widgets/post_card_shimmer.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';

import '../cubit/create_post_states.dart' show AddPostLoading, CreatePostStates;


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final postsCubit = context.read<PostsCubit>();

          await postsCubit.fetchPosts();
        },
        backgroundColor: Colors.white,
        color: AppColors.primaryColorLavenderLangAndText,
        child: CustomScrollView(
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
                padding: EdgeInsets.symmetric( horizontal: 16.w),
                child: AlexText(text: "بوستات"),
              ),
            ),

            BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  // Direct SliverList for loading state
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: const PostCardShimmer(),
                          );
                        },
                        childCount: 5, // Show 5 skeleton loaders
                      ),
                    ),
                  );
                }

                else if (state is PostsLoaded) {
                  final posts = state.postResponse.data;

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final post = posts[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: PostCard(post: post),
                          );
                        },
                        childCount: posts.length,
                      ),
                    ),
                  );
                }

                else if (state is PostsError) {
                  return SliverToBoxAdapter(
                    child: ExceptionView(
                      onPressed: () => context.read<PostsCubit>().fetchPosts(),
                      message: state.message,
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            // Optionally, add a bottom padding so the last item isn't cut off
            SliverToBoxAdapter(
              child: SizedBox(height: 54.h),
            ),
          ],
        ),
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

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({super.key});

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

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
                height: 80,
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
              if (_selectedImage != null)
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: 108,
                      width: 129,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        child: Container(
                            width: 30, height: 30,
                            // padding: EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle
                            ),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1, color: Colors.white)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(Icons.close, color: Colors.white,size: 16,),
                                ))),
                        onTap: () => setState(() => _selectedImage = null),
                      ),
                    ),
                  ],
                ),

              // Your Input Field / Icon Button
              GestureDetector(
                onTap: () {
                  AddPostBottomSheet.show(
                    context,
                    onPickImage: (source) => _pickImage(source),
                  );
                },
                child: Image.asset("assets/icons/image-03.png", width: 22, height: 22),
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
                      if(context.read<CreatePostCubit>().captionController.text.isNotEmpty || _selectedImage != null){
                        final newPost = await context.read<CreatePostCubit>().createPost(_selectedImage);
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

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Compress for better performance
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

}





