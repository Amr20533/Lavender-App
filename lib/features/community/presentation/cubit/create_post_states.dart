
abstract class CreatePostStates {}

class AddPostInitial extends CreatePostStates {}

class AddPostLoading extends CreatePostStates {}

class AddPostSuccess extends CreatePostStates {}

class AddPostError extends CreatePostStates {
  final String message;

  AddPostError(this.message);
}

