import 'package:lavender/features/chat/data/models/chat/inbox_response.dart';
import '../data/models/chat/message_model.dart';

abstract class ChatRepo {
  Future<InboxResponse> getChatInboxes();
  Future<List<MessageModel>> getChatMessages(int receiverId);
  Future<void> sendChatMessage(int receiverId, String message);
}


