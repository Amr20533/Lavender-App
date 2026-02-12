import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/helpers/app_exception.dart';
import 'package:lavender/features/community/data/repositories/local_story_repository.dart';
import 'package:lavender/features/community/data/repositories/story_repository_impl.dart';
import 'package:lavender/features/community/data/models/story_model.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';
import 'package:lavender/features/community/presentation/cubit/story_states.dart';

class StoryCubit extends Cubit<StoryStates> {
  final StoryRepositoryImpl repository;

  StoryCubit(this.repository) : super(StoryInitial());

  /// Fetch all stories
  Future<void> fetchStories() async {
    emit(StoryLoading());
    try {
      final stories = await repository.getStories();

      // Filter out stories older than 24 hours
      final validUserStories =
      stories
          .map((userStory) {
        final validStories =
        userStory.stories.where((s) {
          final difference =
              DateTime.now().difference(s.createdAt).inHours;
          return difference < 24;
        }).toList();

        return UserStories(
          id: userStory.id,
          firstName: userStory.firstName,
          lastName: userStory.lastName,
          profilePic: userStory.profilePic,
          stories: validStories,
        );
      })
          .where((u) => u.stories.isNotEmpty)
          .toList();

      emit(StoryLoaded(validUserStories));

      // Load local stories and merge
      _mergeWithLocalStories();
    } on AppException catch (e) {
      emit(StoryError(e.message));
    } catch (e) {
      // If it's a technical error, still try to show local stories if we have any
      try {
        _mergeWithLocalStories();
      } catch (mergeError) {
        emit(StoryError("حدث خطأ تقني: ${e.toString()}"));
      }
    }
  }

  /// Add story locally for immediate feedback
  void addLocallyStory(
      dynamic file, {
        required String name,
        required String profilePic,
        required int userId,
      }) {
    if (state is StoryLoaded) {
      final currentStories = (state as StoryLoaded).stories;
      final newlist = List<UserStories>.from(currentStories);

      final newStory = Story(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        user: userId,
        createdAt: DateTime.now(),
        likesCount: 0,
        isSeen: false,
        replies: [],
        image: file.path,
      );

      // Save locally for persistence
      LocalStoryRepository.saveStory(newStory, name, profilePic, userId);

      // Check if user exists by ID
      int existingUserIndex = -1;

      // 1. Try exact match
      if (userId != 0) {
        existingUserIndex = newlist.indexWhere((u) => u.id == userId);
      }

      // 2. If not found and we have a valid user, look for provisional "Me" (id == 0) to merge
      if (existingUserIndex == -1 && userId != 0) {
        existingUserIndex = newlist.indexWhere((u) => u.id == 0);
      }

      // 3. If still not found, try to match by current simple "Me" scenario (fallback)
      if (existingUserIndex == -1 && userId == 0) {
        existingUserIndex = newlist.indexWhere((u) => u.id == 0);
      }

      if (existingUserIndex != -1) {
        // User exists (or provisional found), append story and update details
        final existingUser = newlist[existingUserIndex];
        final updatedStories = List<Story>.from(existingUser.stories)
          ..add(newStory);

        final updatedUser = UserStories(
          id: userId != 0 ? userId : existingUser.id, // Update ID if available
          firstName: name, // Update name
          lastName: "",
          profilePic: profilePic, // Update pic
          stories: updatedStories,
        );

        // Move to the beginning
        newlist.removeAt(existingUserIndex);
        newlist.insert(0, updatedUser);
      } else {
        // Create new user section
        final newUserStories = UserStories(
          id: userId,
          firstName: name,
          lastName: "",
          profilePic: profilePic,
          stories: [newStory],
        );
        newlist.insert(0, newUserStories);
      }

      emit(StoryLoaded(newlist));
    }
  }

  void _mergeWithLocalStories() {
    if (state is StoryLoaded) {
      final remoteStories = (state as StoryLoaded).stories;
      final localStories = LocalStoryRepository.getValidLocalStories();

      if (localStories.isEmpty) return;

      final List<UserStories> mergedList = List<UserStories>.from(
        remoteStories,
      );

      for (var localUser in localStories) {
        final existingIndex = mergedList.indexWhere(
              (u) => u.id == localUser.id,
        );

        if (existingIndex != -1) {
          // Merge stories for existing user
          final existingUser = mergedList[existingIndex];

          final Map<String, Story> storyMap = {};
          for (var s in existingUser.stories) {
            storyMap[s.id] = s;
          }
          for (var s in localUser.stories) {
            storyMap[s.id] = s;
          }

          final mergedStories = storyMap.values.toList();
          mergedStories.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          mergedList[existingIndex] = UserStories(
            id: existingUser.id,
            firstName: existingUser.firstName,
            lastName: existingUser.lastName,
            profilePic: existingUser.profilePic,
            stories: mergedStories,
          );
        } else {
          // Add local user to the list
          mergedList.insert(0, localUser);
        }
      }

      emit(StoryLoaded(mergedList));
    }
  }

  /// Delete a story
  void deleteStory(String storyId, int userId) {
    if (state is StoryLoaded) {
      final currentStories = (state as StoryLoaded).stories;
      final newlist = List<UserStories>.from(currentStories);

      final userIndex = newlist.indexWhere((u) => u.id == userId);

      if (userIndex != -1) {
        final userStories = newlist[userIndex];
        final updatedStories =
        userStories.stories.where((s) => s.id != storyId).toList();

        if (updatedStories.isEmpty) {
          // If no stories left, remove the user bubble entirely
          newlist.removeAt(userIndex);
        } else {
          // Update the user bubble with remaining stories
          newlist[userIndex] = UserStories(
            id: userStories.id,
            firstName: userStories.firstName,
            lastName: userStories.lastName,
            profilePic: userStories.profilePic,
            stories: updatedStories,
          );
        }
        emit(StoryLoaded(newlist));
      }
    }
  }
}