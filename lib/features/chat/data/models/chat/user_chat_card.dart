class UserChatCard {
  final int id;
  final String username;
  final String? lastMessagePreview;
  final DateTime? lastMessageTimestamp;

  UserChatCard({required this.id, required this.username, this.lastMessagePreview, this.lastMessageTimestamp});

  factory UserChatCard.fromJson(Map<String, dynamic> json) {
    return UserChatCard(
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }
}