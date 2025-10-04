import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/community/presentaion/cubit/community_cubit.dart';
import 'package:lavender/features/community/presentaion/cubit/community_states.dart';
import 'package:lavender/features/community/presentaion/widgets/community_app_bar.dart';
import 'package:lavender/features/community/presentaion/widgets/post_card.dart';

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
    );
  }
}



