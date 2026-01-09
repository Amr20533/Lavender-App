import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/helpers/app_exception.dart';
import 'package:lavender/features/community/data/repositories/story_repository_impl.dart';
import 'package:lavender/features/community/presentation/cubit/story_states.dart';

class StoryCubit extends Cubit<StoryStates> {
  final StoryRepositoryImpl repository;

  StoryCubit(this.repository) : super(StoryInitial());

  /// Fetch all stories
  Future<void> fetchStories() async {
    emit(StoryLoading());
    try {
      final stories = await repository.getStories();
      emit(StoryLoaded(stories));
    } on AppException catch (e) {
      emit(StoryError(e.message));
    } catch (_) {
      emit(StoryError("Something went wrong. Please try again later."));
    }
  }

  /// Create a new story (text / image / video)
  // Future<void> createStory({
  //   String? caption,
  //   String? imagePath,
  // }) async {
  //   emit(StoryLoading());
  //   try {
  //     final story = await repository.createStory(
  //       caption: caption,
  //       imagePath: imagePath,
  //     );
  //     emit(StoryCreated(story));
  //   } catch (e) {
  //     emit(StoryError(e.toString()));
  //   }
  // }
  //
  // /// Mark story as seen
  // Future<void> markStorySeen(String storyId) async {
  //   try {
  //     await repository.markAsSeen(storyId);
  //     fetchStories(); // refresh updated seen status
  //   } catch (e) {
  //     // no error state needed
  //   }
  // }
}
