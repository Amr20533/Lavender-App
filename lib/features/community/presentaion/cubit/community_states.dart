
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
