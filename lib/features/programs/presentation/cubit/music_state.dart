import 'package:lavender/features/programs/data/models/music_card_model.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MusicState {}

final class MusicInitial extends MusicState {}

final class MusicLoading extends MusicState {}

final class MusicLoaded extends MusicState {
  final List<MusicCardModel> musicCards;
  MusicLoaded(this.musicCards);
}

final class MusicError extends MusicState {
  final String message;
  MusicError(this.message);
}
