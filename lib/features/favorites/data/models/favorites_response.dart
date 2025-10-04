import 'package:lavender/features/favorites/data/models/favorite.dart';

class FavoritesResponse {
  final String status;
  final List<Favorite> favorites;

  FavoritesResponse({
    required this.status,
    required this.favorites,
  });

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    return FavoritesResponse(
      status: json['status'] as String,
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'favorites': favorites.map((f) => f.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'FavoritesResponse(status: $status, favorites: $favorites)';
  }
}

