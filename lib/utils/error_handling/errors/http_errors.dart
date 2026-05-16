import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

sealed class HttpError extends GenericError {
  const HttpError({required this.message});
  final String? message;
}

/// Error that occurs when the server returns a 400 Bad Request status.
class BadRequestError extends HttpError {
  const BadRequestError({String? message}) : super(message: message ?? 'Your request was malformed.');
}

/// Error that occurs when the server returns a 401 Unauthorized status.
class UnauthorizedError extends HttpError {
  const UnauthorizedError({String? message}) : super(message: message ?? 'Authentication failed. Please log in again.');
}

/// Error that occurs when the server returns a 403 Forbidden status.
class AccessDeniedError extends HttpError {
  const AccessDeniedError({String? message})
    : super(message: message ?? 'You do not have permission to access this resource.');
}

/// Error that occurs when the server returns a 404 Not Found status.
class NotFoundError extends HttpError {
  const NotFoundError({String? message}) : super(message: message ?? 'The requested resource was not found.');
}

/// Error that occurs when the server returns a 409 Conflict status.
class ConflictError extends HttpError {
  const ConflictError({String? message})
    : super(message: message ?? 'A conflict occurred with the current state of the resource.');
}

/// Error that occurs when the server returns a 5xx status code.
class ServerError extends HttpError {
  const ServerError({String? message})
    : super(message: message ?? 'Server is currently unavailable. Please try again later.');
}

/// Error that occurs when an unexpected HTTP status code is returned.
class UnknownHttpError extends HttpError {
  final int? statusCode;

  const UnknownHttpError({required this.statusCode, String? message})
    : super(message: message ?? 'An unexpected HTTP error occurred with status: ${statusCode ?? 'unknown'}');
}

/// Error that occurs when a network request is cancelled by the user.
class RequestCancelledError extends HttpError {
  const RequestCancelledError({String? message}) : super(message: message ?? 'The request was cancelled by the user.');
}

/// Error that occurs when sending a request takes too long.
class TimeoutError extends HttpError {
  const TimeoutError({String? message}) : super(message: message ?? 'The request took too long. Please try again.');
}

/// Error that occurs when SSL certificate validation fails.
class BadCertificateError extends HttpError {
  const BadCertificateError({String? message})
    : super(message: message ?? 'SSL certificate validation failed. Your connection might not be secure.');
}

class ConnectionError extends HttpError {
  const ConnectionError({String? message})
    : super(message: message ?? 'Connection error. Please check your connection and try again.');
}

class ConnectionTimeoutError extends HttpError {
  const ConnectionTimeoutError({String? message})
    : super(message: message ?? 'The request timed out. Please try again.');
}

class UnprocessableContentError extends HttpError {
  const UnprocessableContentError({String? message})
    : super(message: message ?? 'The request was not processable. Please try again.');
}

class TooManyRequestsError extends HttpError {
  const TooManyRequestsError({String? message})
    : super(message: message ?? 'Too many requests. Please try again later.');
}

class BadGatewayError extends HttpError {
  const BadGatewayError({String? message}) : super(message: message ?? 'Bad gateway. Please try again later.');
}
