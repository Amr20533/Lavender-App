class Favorite {
  final int id;
  final int specialistId;
  final bool inFavorite;
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.specialistId,
    required this.inFavorite,
    required this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] ?? 0,
      specialistId: json['specialist_id'] ?? 0,
      inFavorite: json['in_favorite'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialist_id': specialistId,
      'in_favorite': inFavorite,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Favorite(id: $id, specialistId: $specialistId,inFavorite: $inFavorite, createdAt: $createdAt)';
  }
}