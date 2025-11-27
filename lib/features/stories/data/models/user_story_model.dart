// 1️⃣ Model للمستخدم والـ Stories
class UserStory {
  final String name;
  final String profileImage;
  final List<StoryItem> stories;
  final bool hasUnseen;

  UserStory({
    required this.name,
    required this.profileImage,
    required this.stories,
    this.hasUnseen = true,
  });
}

class StoryItem {
  final String url;
  final bool isVideo;
  final Duration duration;

  StoryItem({
    required this.url,
    this.isVideo = false,
    this.duration = const Duration(seconds: 5),
  });
}