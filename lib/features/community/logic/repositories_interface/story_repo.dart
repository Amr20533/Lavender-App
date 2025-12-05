import 'package:lavender/features/community/data/models/comment.dart';
import 'package:lavender/features/community/data/models/comment_like_response.dart';
import 'package:lavender/features/community/data/models/like_post_response.dart';
import 'package:lavender/features/community/data/models/post_response.dart';
import 'package:lavender/features/community/data/models/story_model.dart';
import 'package:lavender/features/community/data/models/user_stories.dart';

abstract class StoryRepo {
  Future<List<UserStories>> getStories();


}


