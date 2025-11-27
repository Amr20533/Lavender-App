import 'package:flutter/material.dart';

@immutable
abstract class MusicPlayerState {}

class MusicPlayerInitial extends MusicPlayerState {}

class MusicPlayerPlaying extends MusicPlayerState {
  final Duration currentDuration;
  final Duration totalDuration;
  MusicPlayerPlaying(this.currentDuration, this.totalDuration);
}

class MusicPlayerPaused extends MusicPlayerState {
  final Duration currentDuration;
  final Duration totalDuration;
  MusicPlayerPaused(this.currentDuration, this.totalDuration);
}
