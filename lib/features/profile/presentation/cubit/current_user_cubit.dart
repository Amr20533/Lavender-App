import 'package:bloc/bloc.dart';
import 'package:lavender/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_states.dart';

class CurrentUserCubit extends Cubit<CurrentUserStates> {
  final ProfileRepositoryImpl repository;

  CurrentUserCubit(this.repository) : super(CurrentUserInitial());


  Future<void> fetchCurrentUser() async {
    emit(CurrentUserProfileLoading());
    try {
      final currentUserInfoResponse = await repository.getCurrentUser();
      emit(CurrentUserProfileLoaded(currentUserInfoResponse));
    } catch (e) {
      emit(CurrentUserProfileError(e.toString()));
    }
  }
}
