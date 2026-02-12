import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lavender/features/community/data/models/story_model.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';

class LocalStoryRepository {
  static const String boxName = 'localStoriesBox';

  static Future<void> saveStory(
    Story story,
    String name,
    String profilePic,
    int userId,
  ) async {
    final box = Hive.box(boxName);

    // We store user stories grouped by user ID (or 0 for self if not logged in properly)
    // Structure in box: { userId: { "firstName": name, "profilePic": pic, "stories": [storyJson, ...] } }

    final userData =
        box.get(userId.toString()) ??
        {
          "firstName": name,
          "lastName": "",
          "profilePic": profilePic,
          "stories": [],
        };

    final List<dynamic> storiesJson = List<dynamic>.from(userData["stories"]);
    storiesJson.add(story.toJson());

    userData["stories"] = storiesJson;
    await box.put(userId.toString(), userData);
  }

  static List<UserStories> getValidLocalStories() {
    final box = Hive.box(boxName);
    final List<UserStories> result = [];
    final now = DateTime.now();

    for (var key in box.keys) {
      try {
        final rawData = box.get(key);
        if (rawData == null) continue;

        final Map<String, dynamic> userData = Map<String, dynamic>.from(
          rawData,
        );
        final List<dynamic>? storiesJson = userData["stories"];

        if (storiesJson == null) continue;

        final List<Story> validStories =
            storiesJson
                .map((s) => Story.fromJson(Map<String, dynamic>.from(s)))
                .where((s) => now.difference(s.createdAt).inHours < 24)
                .toList();

        if (validStories.isNotEmpty) {
          // Update the box if some stories were filtered out
          if (validStories.length < storiesJson.length) {
            userData["stories"] = validStories.map((s) => s.toJson()).toList();
            box.put(key, userData);
          }

          result.add(
            UserStories(
              id: int.tryParse(key.toString()) ?? 0,
              firstName: userData["firstName"] ?? "Unknown",
              lastName: userData["lastName"] ?? "",
              profilePic: userData["profilePic"],
              stories: validStories,
            ),
          );
        } else {
          // Remove user data if no valid stories remain
          box.delete(key);
        }
      } catch (e) {
        debugPrint("Error loading local story for key $key: $e");
        // Clear corrupted key
        box.delete(key);
      }
    }

    return result;
  }
}
