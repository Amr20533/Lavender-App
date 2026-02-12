import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/presentation/cubit/music_player_states.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Duration _current = Duration.zero;
  Duration _total = Duration.zero;

  MusicPlayerCubit() : super(MusicPlayerInitial()) {
    // Track playback position
    _audioPlayer.onPositionChanged.listen((position) {
      _current = position;
      _emitState();
    });

    // Track duration of current track
    _audioPlayer.onDurationChanged.listen((duration) {
      _total = duration;
      _emitState();
    });

    // Handle playback completion
    _audioPlayer.onPlayerComplete.listen((_) {
      _current = _total;
      _isPlaying = false;
      emit(MusicPlayerPaused(_current, _total));
    });
  }

  /// Play a new audio file
// In MusicPlayerCubit
  Future<void> play(String audioPath) async {
    try {
      // 1. Reset state so UI shows 'Loading' if needed
      _current = Duration.zero;
      _total = Duration.zero;

      // 2. Set Player Mode to media (High quality)
      await _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);

      if (audioPath.startsWith('http') || audioPath.startsWith('https')) {
        await _audioPlayer.setSourceUrl(audioPath); // Pre-load source
      } else {
        await _audioPlayer.setSourceAsset(audioPath.replaceFirst('assets/', ''));
      }

      // 3. Trigger Play
      await _audioPlayer.resume();
      _isPlaying = true;
      _emitState();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    } else {
      await _audioPlayer.resume();
      _isPlaying = true;
    }
    _emitState();
  }

  /// Seek to a position
  Future<void> seekTo(Duration newDuration) async {
    await _audioPlayer.seek(newDuration);
    _current = newDuration;
    _emitState();
  }

  void _emitState() {
    if (_total == Duration.zero) {
      // Don’t emit until duration is known
      return;
    }

    if (_isPlaying) {
      emit(MusicPlayerPlaying(_current, _total));
    } else {
      emit(MusicPlayerPaused(_current, _total));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}

