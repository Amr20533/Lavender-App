import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/sign_in/data/models/user_model.dart';
import 'package:lavender/features/sign_up/data/models/response_user_model.dart';
import 'package:lavender/features/sign_up/logic/entities/user_entity.dart';
import 'package:lavender/features/sign_up/logic/repositories_interface/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl();

  
 @override
  Future<UserEntity> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try{
      final response = await DioHelper.postData(
        url: ApiConstants.signUp,
        data: {
          "first_name": firstName.trim(),
          "last_name": lastName.trim(),
          "email": email.trim(),
          "password": password.trim(),
        },
      );

    print("*** Respone from API: ${response.data}");

    final ResponseSignUpModel responseModel =
    ResponseSignUpModel.fromJson(response.data);                                                 

    if (responseModel.status != 'success') {
      throw Exception('Sign up failed: ${responseModel.message}');
    }

    return UserEntity(
      id: responseModel.userId ?? '',
      name: "$firstName $lastName",
      email: email,
    );
    }catch (e){
      throw Exception("Error in signUp: $e");
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() => throw UnimplementedError();

  @override
  Future<void> resetPassword(String email) => throw UnimplementedError();

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.signIn,
        data: {
          "email": email.trim(),
          "password": password.trim(),
        },
      );

      print("*** Response from API: ${response.data}");

      final responseModel = UserModel.fromJson(response.data);

      if (responseModel.status != 'success') {
        throw Exception('Sign in failed: ${responseModel.status}');
      }

      return responseModel;
    } catch (e) {
      throw Exception("Error in signIn: $e");
    }
  }


  @override
  Future<void> signOut() async {
    try {
      await SecureStorageHelper.clearTokens();
    } catch (e) {
      throw Exception("Error during sign out: $e");
    }
  }
}