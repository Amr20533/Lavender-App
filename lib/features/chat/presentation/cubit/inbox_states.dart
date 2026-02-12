import 'package:lavender/features/chat/data/models/chat/message_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class InboxState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxSuccess extends InboxState {
  final List<MessageModel> messages;
  final int currentUserId;

  InboxSuccess(this.messages, this.currentUserId);

  @override
  List<Object?> get props => [messages, currentUserId];
}

class InboxError extends InboxState {
  final String errorMessage;

  InboxError(this.errorMessage);
}

class InboxEmpty extends InboxState {}