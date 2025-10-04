import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/favorites/data/models/favorites_response.dart';
import 'package:lavender/features/favorites/logic/favorites_repository.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl();

  @override
  Future<FavoritesResponse> getFavoriteSpecialists() async {

    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.getData(
        url: ApiConstants.getFavorites,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return FavoritesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<void> addToFavorites(int specialist_id, int user, String token) {
    // TODO: implement addToFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromFavorites(int specialist_id, String token) {
    // TODO: implement removeFromFavorites
    throw UnimplementedError();
  }

//   @override
//   Future<void> addToFavorites(int specialist_id, int user, String token) async {
//     final body = {
//       "user": user,
//       "specialist_id": specialist_id,
//     };
//
//     await dio.post(
//       "http://192.168.1.8:8000/api/v1/specialist/favorites/add/",
//       data: body,
//       options: Options(
//         headers: {"Authorization": "Bearer $token"},
//       ),
//     );
//   }
//
//   @override
//   Future<void> removeFromFavorites(int specialist_id, String token) async {
//     await dio.delete(
//       "http://192.168.1.8:8000/api/v1/specialist/favorites/remove/$specialist_id/",
//       options: Options(
//         headers: {"Authorization": "Bearer $token"},
//      ),
// );
// }
}