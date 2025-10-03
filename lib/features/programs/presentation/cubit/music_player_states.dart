import 'package:flutter/material.dart';

@immutable
sealed class MusicPlayerState {}

final class MusicPlayerInitial extends MusicPlayerState {}

final class MusicPlayerPlaying extends MusicPlayerState {
  final Duration currentDuration;
  final Duration totalDuration;
  MusicPlayerPlaying(this.currentDuration, this.totalDuration);
}

final class MusicPlayerPaused extends MusicPlayerState {
  final Duration currentDuration;
  final Duration totalDuration;
  MusicPlayerPaused(this.currentDuration, this.totalDuration);
}
