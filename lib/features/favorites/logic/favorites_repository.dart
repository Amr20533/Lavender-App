import 'package:lavender/features/favorites/data/models/favorites_response.dart';

abstract class FavoritesRepository {
  Future<FavoritesResponse> getFavoriteSpecialists();
  Future<void> addToFavorites(int specialistId);
  Future<void> removeFromFavorites(int specialistId);
}
 