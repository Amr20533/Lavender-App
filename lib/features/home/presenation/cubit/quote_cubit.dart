
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/helpers/app_exception.dart';
import 'package:lavender/features/home/logic/repositories_interface/home_repo.dart';
import 'package:lavender/features/home/presenation/cubit/quote_state.dart';


class QuoteCubit extends Cubit<QuoteState> {
  final HomeRepository homeRepository;

  QuoteCubit(this.homeRepository) : super(QuoteInitial());

  Future<void> fetchQuotes() async {
    emit(QuotesLoading());
    try {
      final quote = await homeRepository.getQuotes();
      emit(QuotesLoaded(quote));
    } on AppException catch (e) {
      emit(QuotesError(e.message));
    } catch (_) {
      emit(QuotesError("Something went wrong. Please try again later."));
    }
  }

}
