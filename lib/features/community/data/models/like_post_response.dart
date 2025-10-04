class LikePostResponse {
  final String status;
  final List<Liker> likes;

  LikePostResponse({required this.status, required this.likes});

  factory LikePostResponse.fromJson(Map<String, dynamic> json) {
    return LikePostResponse(
      status: json['status'] ?? '',
      likes: (json['likes'] as List)
          .map((e) => Liker.fromJson(e))
          .toList(),
    );
  }
}

class Liker {
  final int id;
  final String username;
  final String email;

  Liker({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Liker.fromJson(Map<String, dynamic> json) {
    return Liker(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
