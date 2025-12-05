import 'package:lavender/features/community/data/models/story_model.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';

abstract class StoryStates {}

class StoryInitial extends StoryStates {}

class StoryLoading extends StoryStates {}

class StoryLoaded extends StoryStates {
  final List<UserStories> stories;

  StoryLoaded(this.stories);
}

class StoryCreated extends StoryStates {
  final UserStories story;

  StoryCreated(this.story);
}

class StoryError extends StoryStates {
  final String message;

  StoryError(this.message);
}
