import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/logic/repository_interface/music_repository.dart';
import 'package:lavender/features/programs/presentation/cubit/music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  final MusicRepository repository;

  MusicCubit(this.repository) : super(MusicInitial());

  Future<void> fetchMusicCards() async {
    emit(MusicLoading());
    try {
      final musicCards = await repository.getMusicCards();
      emit(MusicLoaded(musicCards));
    } catch (e) {
      emit(MusicError(e.toString()));
    }
  }
}
