
import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/post_response.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final PostResponse postResponse;

  PostsLoaded(this.postResponse);
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);
}

class LikePostLoading extends PostsState {}

class LikePostLoaded extends PostsState {
  final PostResponse postResponse;

  LikePostLoaded(this.postResponse);
}

class LikePostError extends PostsState {
  final String message;

  LikePostError(this.message);
}

