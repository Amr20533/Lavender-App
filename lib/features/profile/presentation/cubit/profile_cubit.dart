import 'package:bloc/bloc.dart';
import 'package:lavender/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepositoryImpl repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> fetchUsers() async {
    emit(ProfileLoading());
    try {
      final usersResponse = await repository.getUsers();
      emit(ProfileLoaded(usersResponse));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

}
