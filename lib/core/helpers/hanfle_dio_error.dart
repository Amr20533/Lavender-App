import 'package:dio/dio.dart';
import 'package:lavender/core/helpers/app_exception.dart';

AppException handleDioError(DioException e) {
  // Network / timeout errors
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.connectionError) {
    return const NetworkException();
  }

  final statusCode = e.response?.statusCode;
  final data = e.response?.data;

  // Unauthorized
  if (statusCode == 401) {
    return const UnauthorizedException();
  }

  // Server-provided message
  if (data is Map && data['message'] is String) {
    return ServerException(
      data['message'],
      statusCode: statusCode,
    );
  }

  // Fallback
  return const UnknownException();
}
