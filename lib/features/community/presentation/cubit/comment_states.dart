
import 'package:lavender/features/community/data/models/comment.dart';

abstract class CommentStates {}

class CommentsInitial extends CommentStates {}

class CommentsLoading extends CommentStates {}

class CommentsLoaded extends CommentStates {
  final String postId;
  final List<Comment> comments;

  CommentsLoaded(this.postId, this.comments);
}

class CommentAdded extends CommentStates {
  final String postId;
  final List<Comment> comments;

  CommentAdded(this.postId, this.comments);
}

class CommentsError extends CommentStates {
  final String message;

  CommentsError(this.message);
}
