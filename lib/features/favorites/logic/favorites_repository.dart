import 'package:lavender/features/favorites/data/models/favorites_response.dart';

abstract class FavoritesRepository {
  Future<FavoritesResponse> getFavoriteSpecialists();
  Future<void> addToFavorites(int specialist_id, int user, String token);
  Future<void> removeFromFavorites(int specialist_id, String token);
}
 