import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/networking/dio_helper.dart';
import 'package:lavender/features/appointments/data/models/payment_response.dart';
import 'package:lavender/features/appointments/logic/repository_interface.dart';

class AppointmentRepositoryImpl implements AppointmentRepo {
  @override
  Future<PaymentResponse> bookAppointment(int appointmentId) async {
    String? token = await SecureStorageHelper.getAccessToken();
    if (token == null) {
      throw Exception("No access token");
    }

    try {
      final response = await DioHelper.postData(
        url: '${ApiConstants.bookAppointment}/$appointmentId',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        data: {}
      );

      return PaymentResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
