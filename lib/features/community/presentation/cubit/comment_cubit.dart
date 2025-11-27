import 'package:bloc/bloc.dart';
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentation/cubit/comment_states.dart';
import 'package:lavender/features/community/presentation/cubit/community_cubit.dart';
import 'package:lavender/features/community/presentation/cubit/community_states.dart';

class CommentCubit extends Cubit<CommentStates> {
  final CommunityRepositoryImpl repository;
  final PostsCubit postsCubit;

  CommentCubit(this.repository, this.postsCubit) : super(CommentsInitial());

  Future<void> fetchComments(String postId) async {
    emit(CommentsLoading());
    try {
      final comments = await repository.getComments(postId);
      emit(CommentsLoaded(postId, comments));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
  Future<void> addComment(String postId, String text) async {
    if (text.trim().isEmpty) return;

    try {
      final newComment = await repository.addComment(postId, text);

      if (state is CommentsLoaded) {
        final currentState = state as CommentsLoaded;
        final updated = [newComment, ...currentState.comments];
        emit(CommentAdded(postId, updated));
        emit(CommentsLoaded(postId, updated));
      } else {
        emit(CommentAdded(postId, [newComment]));
        emit(CommentsLoaded(postId, [newComment]));
      }

      postsCubit.addCommentToPost(postId, newComment);

    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  Future<void> toggleLike(String commentId, int currentUserId) async {
    if (state is! CommentsLoaded) return;

    final currentState = state as CommentsLoaded;
    final comments = List<Comment>.from(currentState.comments);
    final index = comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return;

    try {
      // Call API to like/unlike comment
      final likeResponse = await repository.likeComment(commentId);

      // Update comment likes count and isLiked from API
      final updatedComment = comments[index].copyWith(
        likesCount: likeResponse.likesCount,
        isLiked: !comments[index].isLiked,
      );

      comments[index] = updatedComment;

      emit(CommentsLoaded(currentState.postId, comments));

      // Optionally update PostsCubit to keep post.comments consistent
      final postsState = postsCubit.state;
      if (postsState is PostsLoaded) {
        final posts = List<Post>.from(postsState.postResponse.data);
        final postIndex = posts.indexWhere((p) => p.id == currentState.postId);
        if (postIndex != -1) {
          final postComments = List<Comment>.from(posts[postIndex].comments);
          final commentIdx = postComments.indexWhere((c) => c.id == commentId);
          if (commentIdx != -1) {
            postComments[commentIdx] = updatedComment;
            posts[postIndex] = posts[postIndex].copyWith(comments: postComments);
            postsCubit.emit(PostsLoaded(postsState.postResponse.copyWith(data: posts)));
          }
        }
      }
    } catch (e) {
      emit(CommentsError("Failed to like comment: $e"));
    }
  }



}
