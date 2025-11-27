import 'package:bloc/bloc.dart';
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';

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

  Future<void> toggleLike(String postId, int currentUserId) async {
    if (state is! PostsLoaded) return;

    final currentState = state as PostsLoaded;
    final posts = List<Post>.from(currentState.postResponse.data);
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;
  
    try {
      final likeResponse = await repository.likePost(postId);

      // Update likes in post using API data
      final updatedPost = posts[index].copyWith(
        likesCount: likeResponse.likes.length,
        isLiked: likeResponse.likes.any((l) => l.id == currentUserId),
      );

      posts[index] = updatedPost;

      emit(PostsLoaded(currentState.postResponse.copyWith(data: posts)));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  void addCommentToPost(String postId, Comment newComment) {
    if (state is! PostsLoaded) return;

    final currentState = state as PostsLoaded;
    final posts = List<Post>.from(currentState.postResponse.data);
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final updatedComments = [newComment, ...posts[index].comments];
    final updatedPost = posts[index].copyWith(comments: updatedComments);

    posts[index] = updatedPost;
    emit(PostsLoaded(currentState.postResponse.copyWith(data: posts)));
  }

}
