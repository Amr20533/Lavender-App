import 'package:bloc/bloc.dart';
import 'package:lavender/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_states.dart';
import '../../data/models/users_response.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepositoryImpl repository;

  // Cache the last response to prevent UI flickering
  UsersResponse? _cachedUsers;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> fetchUsers({bool isRefresh = false}) async {
    // Only show full-screen loading if we don't have cached data
    if (_cachedUsers == null) {
      emit(ProfileLoading());
    }

    try {
      final usersResponse = await repository.getUsers();
      _cachedUsers = usersResponse; // Save to cache
      emit(ProfileLoaded(usersResponse));
    } catch (e) {
      // If we have cached data, don't show an error screen, maybe just a toast
      if (_cachedUsers != null) {
        emit(ProfileLoaded(_cachedUsers!));
      } else {
        emit(ProfileError(e.toString()));
      }
    }
  }
}