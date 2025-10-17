
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/home/logic/repositories_interface/home_repo.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future<void> fetchSpecialists() async {
    emit(HomeLoading());
    try {
      final specialists = await homeRepository.getSpecialists();
      emit(HomeLoaded(specialists));
    } catch (e) {
      emit(HomeError("فشل تحميل البيانات: ${e.toString()}"));
    }
  }
}

// home_bloc.dart
/* 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../logic/repositories_interface/home_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<FetchSpecialistsEvent>(_onFetchSpecialists);
  }

  Future<void> _onFetchSpecialists(
    FetchSpecialistsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final specialists = await homeRepository.getSpecialists();
      emit(HomeLoaded(specialists));
    } catch (e) {
      emit(HomeError("فشل تحميل البيانات: ${e.toString()}"));
    }
  }
}*/