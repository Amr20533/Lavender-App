import 'package:dio/dio.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/programs/data/models/music_card_model.dart';
import 'package:lavender/features/programs/logic/repository_interface/music_repository.dart';

class MusicRepositoryImpl implements MusicRepository {
  @override
  Future<List<MusicCardModel>> getMusicCards() async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getMusicCards,
      );
      return (response.data as List)
          .map((json) => MusicCardModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
