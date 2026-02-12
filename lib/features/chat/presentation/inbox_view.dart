import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/app_bar_shadow.dart';
import 'package:lavender/features/chat/presentation/cubit/inbox_states.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_list.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_loading_view.dart';
import 'package:lavender/features/community/presentation/screen/stories_bar.dart';
import 'cubit/inbox_cubit.dart';


class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AlexText(text: "الدردشة"),
          toolbarHeight: 70,
          leading: Container(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: AppBarShadow(),
          ),
        ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: StoriesBar()),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AlexText(text: "كل الرسائل", fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          BlocBuilder<InboxCubit, InboxState>(
            builder: (context, state) {
              if (state is InboxLoading) {
                // يجب أن يكون الـ Loading أيضاً Sliver
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is InboxSuccess) {
                // الآن InboxList ترجع SliverList، فتعمل هنا مباشرة
                return InboxList(
                    messages: state.messages,
                    currentUserId: state.currentUserId
                );
              } else if (state is InboxEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text("لا توجد رسائل بعد.")),
                );
              } else if (state is InboxError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.errorMessage)),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}


