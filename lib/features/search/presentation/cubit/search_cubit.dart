import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/search/logic/search_repository.dart';
import 'package:lavender/features/search/presentation/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  void search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await repository.searchSpecialists(query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clear() {
    emit(SearchInitial());
  }
}
