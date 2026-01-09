abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException()
      : super("No internet connection. Please check your network and try again.");
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super("Your session has expired. Please sign in again.", statusCode: 401);
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class UnknownException extends AppException {
  const UnknownException()
      : super("Something went wrong. Please try again later.");
}
