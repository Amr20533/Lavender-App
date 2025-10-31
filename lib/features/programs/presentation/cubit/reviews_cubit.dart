import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());

  final Map<int, double> _doctorRatings = {};

  double getDoctorRating(int doctorId) {
    return _doctorRatings[doctorId] ?? 0.0;
  }

  void updateDoctorRating(int doctorId, double rating) {
    _doctorRatings[doctorId] = rating;
    emit(ReviewsUpdated(doctorId, rating));
  }
}
