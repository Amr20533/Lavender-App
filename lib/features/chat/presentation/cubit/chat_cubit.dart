import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/features/chat/data/models/chat/inbox_user_profile.dart';
import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import 'package:lavender/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:lavender/features/chat/presentation/cubit/chat_states.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositoryImpl chatRepo;
  final int receiverId;
  Timer? _pollingTimer;

  ChatCubit({required this.chatRepo, required this.receiverId}) : super(ChatInitial());

  // 1. Fetch Messages
  Future<void> getMessages({bool silent = false}) async {
    // 1. Get the ID once from storage
    final idString = await SecureStorageHelper.getCurrentUserId();
    final myId = int.parse(idString ?? '0');

    if (!silent) emit(ChatLoading(currentUserId: myId));

    try {
      final messages = await chatRepo.getChatMessages(receiverId);
      emit(ChatLoaded(messages, currentUserId: myId));
    } catch (e) {
      if (!silent) emit(ChatError(e.toString()));
    }
  }

  // 2. Send Message
  Future<void> sendMessage({
    required String text,
    required int currentUserId,
    required InboxUserProfile receiverProfile,
  }) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;

      // 1. Create the optimistic (fake) message
      final tempMessage = MessageModel(
        id: -1, // Temporary flag
        sender: currentUserId,
        receiver: receiverProfile.user.id,
        message: text,
        isRead: false,
        timestamp: DateTime.now(),
        senderProfile: InboxUserProfile.empty(),
        receiverProfile: receiverProfile,
      );

      // 2. Push to UI immediately
      final updatedMessages = List<MessageModel>.from(currentState.messages)..add(tempMessage);
      emit(ChatLoaded(updatedMessages, currentUserId: currentUserId));

      try {
        // 3. Network Request
        final realMessage = await chatRepo.sendChatMessage(receiverProfile.user.id, text);

        // 4. Replace temp with real
        final finalMessages = currentState.messages.map((m) => m.id == -1 ? realMessage : m).toList();
        emit(ChatLoaded(finalMessages, currentUserId: currentUserId));
      } catch (e) {
        // 5. Error handling: remove the temp message
        final errorMessages = List<MessageModel>.from(currentState.messages)..removeWhere((m) => m.id == -1);
        emit(ChatLoaded(errorMessages, currentUserId: currentUserId));
      }
    }
  }
  // 3. Polling Logic
  void startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      getMessages(silent: true);
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}