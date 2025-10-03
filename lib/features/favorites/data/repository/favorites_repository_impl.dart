import 'package:dio/dio.dart';
import 'package:lavender/features/favorites/logic/favorites_repository.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final Dio dio;

  FavoritesRepositoryImpl(this.dio);

  @override
  Future<List<Specialist>> getFavoriteSpecialists(String token) async {
    final response = await dio.get(
      "http://192.168.1.8:8000/api/v1/specialist/favorites/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    final data = response.data;

    // السيرفر بيرجع Map مش List
    if (data is Map<String, dynamic> && data.containsKey("favorites")) {
      final favorites = data["favorites"] as List;
      return favorites.map((json) => Specialist.fromJson(json)).toList();
    }

    return [];
  }

  @override
  Future<void> addToFavorites(int specialist_id, int user, String token) async {
    final body = {
      "user": user,
      "specialist_id": specialist_id,
    };

    await dio.post(
      "http://192.168.1.8:8000/api/v1/specialist/favorites/add/",
      data: body,
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  @override
  Future<void> removeFromFavorites(int specialist_id, String token) async {
    await dio.delete(
      "http://192.168.1.8:8000/api/v1/specialist/favorites/remove/$specialist_id/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
     ),
);
}
}