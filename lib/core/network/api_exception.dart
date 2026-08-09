class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode)';
}

// Exception types
class NetworkException extends ApiException {
  const NetworkException(
      {super.message = 'No Internet connection. Please check your network.'});
}

class ServerException extends ApiException {
  const ServerException(
      {super.message = 'Server error occurred. Please try again later.',
      super.statusCode});
}

class UnknownApiException extends ApiException {
  const UnknownApiException({super.message = 'An unexpected error occurred.'});
}
