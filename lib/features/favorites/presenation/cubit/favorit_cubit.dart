import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/favorites/logic/favorites_repository.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_state.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial());

  Future<void> fetchFavorites() async {
    try {
      emit(FavoritesLoading());
      final favorites = await repository.getFavoriteSpecialists();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      print("Error fetching favorites: $e");
      emit(FavoritesError(e.toString()));
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

