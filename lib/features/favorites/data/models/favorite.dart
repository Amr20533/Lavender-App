class Favorite {
  final int id;
  final int specialistId;
  final int user;
  final bool inFavorite;
  final DateTime? createdAt;

  Favorite({
    required this.id,
    required this.specialistId,
    required this.user,
    required this.inFavorite,
    this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] as int,
      specialistId: json['specialist_id'] as int,
      user: json['user'] as int,
      inFavorite: json['in_favorite'] as bool,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialist_id': specialistId,
      'user': user,
      'in_favorite': inFavorite,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Favorite(id: $id, specialistId: $specialistId, user: $user, inFavorite: $inFavorite, createdAt: $createdAt)';
  }
}