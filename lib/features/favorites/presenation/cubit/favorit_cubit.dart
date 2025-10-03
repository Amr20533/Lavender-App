import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/favorites/logic/favorites_repository.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class FavoritesCubit extends Cubit<List<Specialist>> {
  final FavoritesRepository repository;
  final String token;
  final int user;

  FavoritesCubit(this.repository, this.token, this.user) : super([]);

  // 1. جلب الفيفوريت من السيرفر
  Future<void> fetchFavorites() async {
    try {
      final favorites = await repository.getFavoriteSpecialists(token);
      emit(favorites);
    } catch (e) {
      print("Error fetching favorites: $e");
    }
  }

  // 2. إضافة / إزالة فيفوريت
 /* Future<void> toggleFavorite(Specialist specialist) async {
    final isCurrentlyFavorite =
        state.any((fav) => fav.specialist_id == specialist.specialist_id);
    try {
      if (isCurrentlyFavorite) {
        await repository.removeFromFavorites(specialist.specialist_id, token);

        // امسح من الstate
        emit(state.where((fav) => fav.specialist_id != specialist.specialist_id).toList());
      } else {
        await repository.addToFavorites(user, specialist.specialist_id, token);

        // أضف للstate
        emit([...state, specialist]);
      }
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  // 3. helper function (لـ UI)
  bool isFavorite(String specialist_id) {
    return state.any((fav) => fav.specialist_id == specialist_id);

}
    */
}

