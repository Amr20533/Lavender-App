
import 'package:lavender/features/chat/data/models/chat/message_model.dart';

class InboxResponse {
  final List<MessageModel> data;

  InboxResponse({required this.data});

  factory InboxResponse.fromJson(Map<String, dynamic> json) {
    return InboxResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((e) => MessageModel.fromJson(e)).toList()
          : [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}