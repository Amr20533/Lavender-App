import 'package:bloc/bloc.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentaion/cubit/community_states.dart';

class PostsCubit extends Cubit<PostsState> {
  final CommunityRepositoryImpl repository;

  PostsCubit(this.repository) : super(PostsInitial());

  Future<void> fetchPosts() async {
    emit(PostsLoading());
    try {
      final postResponse = await repository.getPosts();
      emit(PostsLoaded(postResponse));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
