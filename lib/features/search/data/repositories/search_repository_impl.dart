import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/home/data/models/specialist.dart';
import 'package:lavender/features/search/logic/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<List<Specialist>> searchSpecialists(String query) async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.searchSpecialists,
        query: {
          'search': query,
        },
      );

      final data = response.data;

      final int count = data['count'] as int;
      final resultsWrapper = data['results'] as Map<String, dynamic>;
      if (resultsWrapper['status'] != 'success') {
        throw Exception("Search failed: ${resultsWrapper['status']}");
      }

      final List<dynamic> specialistsJson = resultsWrapper['specialists'] as List<dynamic>;
      return specialistsJson
          .map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error searching specialists: $e");
    }
  }
}
