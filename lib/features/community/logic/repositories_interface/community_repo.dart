import 'package:lavender/features/community/data/models/like_post_response.dart';
import 'package:lavender/features/community/data/models/post_response.dart';

abstract class CommunityRepository {
  Future<PostResponse> getPosts();
  Future<LikePostResponse> likePost(String postId);

}


