import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/chat/data/models/chat/inbox_user_profile.dart';
import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import 'package:lavender/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:lavender/features/chat/presentation/cubit/chat_states.dart';
import 'package:lavender/features/chat/presentation/cubit/inbox_cubit.dart';
import 'package:lavender/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:lavender/features/chat/presentation/widgets/input_section.dart';

class ChatLayout extends StatefulWidget {
  final InboxUserProfile user;
  const ChatLayout({super.key, required this.user});

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int myId = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChatCubit>();
    cubit.getMessages();
    cubit.startPolling();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 2,
        // backgroundColor: Colors.white,
        toolbarHeight: 70,
        leadingWidth: 250,
        leading: Row(
          spacing: 8,
          children: [
            BackIcon(
                onTap:(){
                  final cubit = context.read<InboxCubit>();
                  cubit.fetchInboxes();
                  Navigator.pop(context);
                }
            ),
            SizedBox.shrink(),
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: CustomCachedNetworkImage(
                  imageUrl: '${widget.user.profilePic}',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlexText(text: "${widget.user.user.firstName} ${widget.user.user.lastName}"),
                Row(
                  spacing: 4,
                  children: [
                    Container(width: 6,height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green4
                    ),
                    ),
                    AlexText(text: 'متاح الأن',color: AppColors.green4, fontSize: 12,)
                  ],
                )
              ],
            )
          ],
        ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          int? myId;
          List<MessageModel> messages = [];

          if (state is ChatLoading) {
            myId = state.currentUserId;
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatLoaded) {
            myId = state.currentUserId;
            messages = state.messages;
          }

          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? const Center(child: Text("No messages"))
                    : ListView.separated(
                  controller: _scrollController,
                  itemCount: messages.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderProfile.role == "patient" && msg.sender == myId;
                    // final isMe = msg.sender == myId;
                    // final isMe = msg.sender == myId || msg.receiver == myId;

                    return ChatBubble(isMe: !isMe, msg: msg);
                  },
                  separatorBuilder: (_, __)=> SizedBox(height: 4,),
                ),
              ),

              if (myId != null)
                InputSection(
                  messageController: _messageController,
                  currentUserId: myId,
                  receiverProfile: widget.user,
                ),
            ],
          );
        },
      ),
    );
  }
}

