import 'package:flutter/material.dart';
import 'package:lavender/features/home/data/models/specialists_response.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final SpecialistsResponse specialists;
  HomeLoaded(this.specialists);
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
