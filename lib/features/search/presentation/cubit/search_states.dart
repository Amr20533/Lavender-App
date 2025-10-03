import 'package:lavender/features/home/data/models/specialist.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Specialist> specialists;
  SearchLoaded(this.specialists);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}