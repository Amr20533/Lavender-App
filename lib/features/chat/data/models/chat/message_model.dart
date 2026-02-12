
import 'package:lavender/features/chat/data/models/chat/inbox_user_profile.dart';

class MessageModel {
  final int id;
  final int sender;
  final int receiver;
  final InboxUserProfile senderProfile;
  final InboxUserProfile receiverProfile;
  final String message;
  final bool isRead;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.senderProfile,
    required this.receiverProfile,
    required this.message,
    required this.isRead,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? 0,
      sender: json['sender'] ?? 0,
      receiver: json['receiver'] ?? 0,
      // Safely handle potential nulls for profiles
      senderProfile: json['sender_profile'] != null
          ? InboxUserProfile.fromJson(json['sender_profile'])
          : InboxUserProfile.empty(), // Create an empty factory in InboxUserProfile
      receiverProfile: json['receiver_profile'] != null
          ? InboxUserProfile.fromJson(json['receiver_profile'])
          : InboxUserProfile.empty(),
      message: json['message'] ?? "",
      isRead: json['is_read'] ?? false,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'receiver_profile': receiverProfile.toJson(),
      'sender_profile': senderProfile.toJson(),
      'message': message,
      'is_read': isRead,
      'timestamp': timestamp.toIso8601String(),
    };
  }

}
