part of 'reviews_cubit.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsUpdated extends ReviewsState {
  final int doctorId;
  final double rating;

  ReviewsUpdated(this.doctorId, this.rating);
}
