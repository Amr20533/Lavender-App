import 'package:dio/dio.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/community/data/models/post_response.dart';
import '../../logic/repositories_interface/community_repo.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  @override
  Future<PostResponse> getPosts() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getPosts,
      );

      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

}
