import 'package:lavender/features/home/data/models/specialist.dart';

abstract class FavoritesRepository {
  Future<List<Specialist>> getFavoriteSpecialists(String token);
  Future<void> addToFavorites(int specialist_id, int user, String token);
  Future<void> removeFromFavorites(int specialist_id, String token);
}
 