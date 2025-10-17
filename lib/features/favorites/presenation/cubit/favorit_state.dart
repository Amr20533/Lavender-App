import 'package:lavender/features/favorites/data/models/favorites_response.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final FavoritesResponse favoritesResponse;
  FavoritesLoaded(this.favoritesResponse);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class AddFavoritesLoading extends FavoritesState {}

class AddFavoritesLoaded extends FavoritesState {
  final FavoritesResponse favoritesResponse;
  AddFavoritesLoaded(this.favoritesResponse);
}

class AddFavoritesError extends FavoritesState {
  final String message;
  AddFavoritesError(this.message);
}