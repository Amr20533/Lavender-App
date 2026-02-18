import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/presentation/cubit/music_player_states.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  late final StreamSubscription<Duration> _positionSub;
  late final StreamSubscription<Duration?> _durationSub;
  late final StreamSubscription<void> _completeSub;

  bool _isPlaying = false;

  Duration _current = Duration.zero;
  Duration _total = Duration.zero;

  MusicPlayerCubit() : super(MusicPlayerInitial()) {

    _positionSub = _audioPlayer.onPositionChanged.listen((position) {
      _current = position;
      _emitState();
    });

    _durationSub = _audioPlayer.onDurationChanged.listen((duration) {
      if (duration != null) {
        _total = duration;
        _emitState();
      }
    });

    _completeSub = _audioPlayer.onPlayerComplete.listen((_) {
      _current = _total;
      _isPlaying = false;

      if (!isClosed) {
        emit(MusicPlayerPaused(_current, _total));
      }
    });
  }

  Future<void> play(String audioPath) async {
    try {
      _current = Duration.zero;
      _total = Duration.zero;

      await _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);

      if (audioPath.startsWith('http')) {
        await _audioPlayer.setSourceUrl(audioPath);
      } else {
        await _audioPlayer.setSourceAsset(
          audioPath.replaceFirst('assets/', ''),
        );
      }

      await _audioPlayer.resume();
      _isPlaying = true;
      _emitState();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

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

  Future<void> seekTo(Duration newDuration) async {
    await _audioPlayer.seek(newDuration);
    _current = newDuration;
    _emitState();
  }

  void _emitState() {
    if (isClosed) return;              // 🔥 Critical fix
    if (_total == Duration.zero) return;

    emit(
      _isPlaying
          ? MusicPlayerPlaying(_current, _total)
          : MusicPlayerPaused(_current, _total),
    );
  }

  @override
  Future<void> close() async {
    await _positionSub.cancel();
    await _durationSub.cancel();
    await _completeSub.cancel();
    await _audioPlayer.dispose();
    return super.close();
  }
}

