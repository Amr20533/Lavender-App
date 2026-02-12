import 'message_model.dart';

class MessagesResponse {
  final List<MessageModel> messages;

  MessagesResponse({required this.messages});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      messages: (json['messages'] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList(),
    );
  }
}
