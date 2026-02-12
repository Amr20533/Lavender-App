class UserModel {
  final String status;
  final String accessToken;
  final String refreshToken;
  final int id;

  UserModel({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      status: json['status'] as String,
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );
  }
}
