import 'package:lavender/features/favorites/data/models/favorites_response.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

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