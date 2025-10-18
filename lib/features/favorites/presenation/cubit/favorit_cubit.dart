import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/favorites/data/models/favorite.dart';
import 'package:lavender/features/favorites/data/models/favorites_response.dart';
import 'package:lavender/features/favorites/logic/favorites_repository.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_state.dart';

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

  Future<void> toggleFavorite(int specialistId) async {
    if (state is! FavoritesLoaded) return;
    final currentState = state as FavoritesLoaded;

    List<Favorite> favs = List.from(currentState.favoritesResponse.favorites);

    final isFav = favs.any((f) => f.specialistId == specialistId);

    try {
      if (isFav) {
        // Optimistically remove locally
        favs.removeWhere((f) => f.specialistId == specialistId);
        emit(FavoritesLoaded(FavoritesResponse(favorites: favs, status: 'success')));

        await repository.removeFromFavorites(specialistId);
      } else {
        await repository.addToFavorites(specialistId);
        // Sync with server
        final updated = await repository.getFavoriteSpecialists();
        emit(FavoritesLoaded(updated));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

}

