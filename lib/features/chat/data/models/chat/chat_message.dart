class ChatMessage {
  final int senderId;
  final String message;
  final DateTime timestamp;

  ChatMessage({required this.senderId, required this.message, required this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final messageData = json['message'] as Map<String, dynamic>;

    return ChatMessage(
      senderId: messageData['sender']['id'] as int,
      message: messageData['message'] as String,
      timestamp: DateTime.parse(messageData['timestamp'] as String),
    );
  }
}