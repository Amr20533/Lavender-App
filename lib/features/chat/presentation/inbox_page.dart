import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/chat/presentation/cubit/inbox_states.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_list.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_loading_view.dart';
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
      ),
      body: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {
          if (state is InboxLoading) {
            return const InboxLoadingView();
          } else if (state is InboxSuccess) {
            return InboxList(messages: state.messages, currentUserId: state.currentUserId);
          } else if (state is InboxError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is InboxEmpty) {
            return const Center(child: Text("No Messages yet."));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


