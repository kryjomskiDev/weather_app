import 'package:dio/dio.dart';
import 'package:weather_app/utils/error_handling/errors/http_errors.dart';

extension DioErrorHandlerExtension on DioException {
  HttpError get handleException => _handleDioException(this);
}

const String errorMessageString = 'message';

/// Handles Dio-specific exceptions and maps them to appropriate error types.
HttpError _handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionError:
      return const ConnectionError();
    case DioExceptionType.connectionTimeout:
      return const ConnectionTimeoutError();
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutError();
    case DioExceptionType.badResponse:
      return _handleDioBadResponse(error);
    case DioExceptionType.cancel:
      return const RequestCancelledError();
    case DioExceptionType.unknown:
      return UnknownHttpError(
        statusCode: error.response?.statusCode,
        message: 'An unknown network error occurred. Please check your connection and try again.',
      );

    case DioExceptionType.badCertificate:
      return const BadCertificateError();
  }
}

/// Handles Dio bad response exceptions and maps HTTP status codes to error types.
HttpError _handleDioBadResponse(DioException error) {
  final int? statusCode = error.response?.statusCode;
  final String? errorMessage = error.response?.data is Map<String, dynamic>
      ? (error.response?.data as Map<String, dynamic>)[errorMessageString] as String?
      : error.response?.statusMessage;

  switch (statusCode) {
    case 400:
      return BadRequestError(message: errorMessage);
    case 401:
      return UnauthorizedError(message: errorMessage);
    case 403:
      return AccessDeniedError(message: errorMessage);
    case 404:
      return NotFoundError(message: errorMessage);
    case 409:
      return ConflictError(message: errorMessage);
    case 422:
      return UnprocessableContentError(message: errorMessage);
    case 429:
      return TooManyRequestsError(message: errorMessage);
    case 500:
    case 502:
    case 503:
      return ServerError(message: errorMessage);
    default:
      return UnknownHttpError(statusCode: statusCode ?? 0, message: errorMessage);
  }
}
