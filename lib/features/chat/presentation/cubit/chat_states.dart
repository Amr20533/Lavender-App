import 'package:flutter/foundation.dart' show immutable;
import 'package:lavender/features/chat/data/models/chat/message_model.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  final int? currentUserId;
  ChatLoading({this.currentUserId});
}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  final int currentUserId;
  final bool isSending;

  ChatLoaded(this.messages, {required this.currentUserId, this.isSending = false});
}
class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}