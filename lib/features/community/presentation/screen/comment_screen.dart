import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/themes/stylesdart.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/circularIcon.dart';
import 'package:lavender/features/community/presentation/cubit/comment_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/comment_states.dart';
import 'package:lavender/features/profile/data/models/user.dart';
import 'package:lavender/features/profile/data/models/user_with_profile.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_states.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../profile/presentation/cubit/profile_cubit.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Defer Cubit call until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getComments();
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void getComments(){
    if (mounted) {
      context.read<CommentCubit>().fetchComments(widget.postId);
    }
  }

  void _sendComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    context.read<CommentCubit>().addComment(widget.postId, text);
    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AlexText(text: "التعليقات"),
        leading: BackIcon(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentCubit, CommentStates>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommentsLoaded) {
                    final comments = state.comments;

                    if (comments.isEmpty) {
                      return const Center(child: Text("لا توجد تعليقات بعد."));
                    }

                    return BlocBuilder<ProfileCubit, ProfileStates>(
                      builder: (context, profileState) {
                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];

                            String userName = "مستخدم غير معروف";
                            String? profilePic;

                            if (profileState is ProfileLoaded) {
                              final users = profileState.usersResponse.users;

                              final user = users.firstWhere(
                                (u) => u.user.id == comment.user,
                                orElse: () => UserWithProfile(
                                  user: User(id: 0, firstName: 'مستخدم', lastName: 'غير معروف', email: ''),
                                  profilePic: '',
                                ),
                              );

                              userName = "${user.user.firstName} ${user.user.lastName}".trim();
                              profilePic = user.profilePic?.isNotEmpty == true ? user.profilePic : null;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: profilePic != null
                                        ? NetworkImage("${ApiConstants.imagePath}$profilePic")
                                        : const AssetImage('assets/icons/user.png') as ImageProvider,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userName,
                                            style: GoogleFonts.alexandria(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            comment.content,
                                            style: GoogleFonts.alexandria(fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            timeago.format(DateTime.parse(comment.createdAt)),
                                            style: GoogleFonts.alexandria(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  BlocBuilder<CurrentUserCubit, CurrentUserStates>(
                                                    builder: (context, userState) {
                                                      if (userState is CurrentUserProfileLoaded) {
                                                        final currentUserId = userState.currentUserInfoResponse.profile.user.id;

                                                        return GestureDetector(
                                                          onTap: () {
                                                            context.read<CommentCubit>().toggleLike(comment.id, currentUserId);
                                                          },
                                                          child: Image.asset(
                                                            comment.isLiked == true
                                                                ? 'assets/icons/heart_filled.png'
                                                                : 'assets/icons/heart.png',
                                                            width: 24.w,
                                                            height: 24.w,
                                                            color: comment.isLiked == true
                                                                ? Colors.red
                                                                : AppColors.primaryColorLavenderLangAndText,
                                                          ),
                                                        );
                                                      }
                                                      return const SizedBox.shrink();
                                                    }
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  AlexText(
                                                    text: "${comment.likesCount} اعجاب",
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is CommentsError) {
                    return Center(child: Text("خطأ: ${state.message}"));
                  }
                  return const SizedBox();
                },
              ),
            ),

            // Bottom text field - ده الجزء المهم
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 10.h,
                bottom: 10.h,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _commentController,
                      focusNode: _focusNode,
                      autofocus: true,
                      style: TextStyles.bodyBold,
                      decoration: InputDecoration(
                        hintText: "اكتب تعليقك...",
                        hintStyle: GoogleFonts.alexandria(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: AppColors.grey3,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onFieldSubmitted: (_) => _sendComment(),
                    ),
                  ),
                  // SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: _sendComment,
                    child: CircularIcon(icon: 'send-2.png',),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ده المفتاح - يخلي الشاشة تتحرك مع الكيبورد
      resizeToAvoidBottomInset: true,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

}
