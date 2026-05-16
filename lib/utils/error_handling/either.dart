import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

/// A generic abstract class representing a value that can be one of two types.
/// This is a fundamental concept in functional programming for handling
/// success and failure scenarios in a type-safe manner.
///
/// L typically represents the Failure case (Left).
/// R typically represents the Success case (Right).
abstract class Either<L, R> {
  const Either();

  /// Static convenience method for creating a success result with custom type
  /// Useful for creating a success result without having to specify the type
  static Either<GenericError, T> success<T>(T value) => Success<GenericError, T>(value);

  /// Static convenience method for creating a failure result with custom type
  static Either<GenericError, T> failure<T>(GenericError error) => Failure<GenericError, T>(error);

  /// Folds over the `Either` instance, allowing you to handle both the
  /// Failure and Success cases in a single, unified block of code.
  ///
  /// The `ifFailure` function is called if the instance is `Failure`.
  /// The `ifSuccess` function is called if the instance is `Success`.
  T fold<T>(T Function(L) ifFailure, T Function(R) ifSuccess);

  /// Returns the value of the `Success` if it exists.
  /// Otherwise, it returns the provided `defaultValue`.
  R getOrElse(R defaultValue);

  /// Maps the value of the `Success` to a new type, if it's a `Success`.
  /// If the instance is a `Failure`, it is returned unchanged.
  ///
  /// This is useful for transforming a success value.
  Either<L, T> map<T>(T Function(R) f);

  /// Maps the value of the `Success` to a new `Either` instance, if it's a `Success`.
  /// This is used to chain multiple `Either`-returning operations.
  /// If the current instance is a `Failure`, the chain is halted, and the `Failure`
  /// is returned without calling the function `f`.
  Either<L, T> flatMap<T>(Either<L, T> Function(R) f);

  /// Returns `true` if the `Either` is a `Failure`.
  bool isFailure() => fold((_) => true, (_) => false);

  /// Returns `true` if the `Either` is a `Success`.
  bool isSuccess() => fold((_) => false, (_) => true);
}

/// A concrete class representing the "Failure" case of `Either`.
/// It holds a value of type `L`.
class Failure<L, R> extends Either<L, R> {
  final L value;
  const Failure(this.value);

  /// Static convenience method for creating a failure result with custom type
  /// Useful for creating a failure result without having to specify the type
  static Either<GenericError, T> of<T>(GenericError value) => Failure<GenericError, T>(value);

  @override
  T fold<T>(T Function(L) ifLeft, T Function(R) ifRight) => ifLeft(value);

  @override
  R getOrElse(R defaultValue) => defaultValue;

  @override
  Either<L, T> map<T>(T Function(R) f) => Failure<L, T>(value);

  @override
  Either<L, T> flatMap<T>(Either<L, T> Function(R) f) => Failure<L, T>(value);
}

/// A concrete class representing the "Success" case of `Either`.
/// It holds a value of type `R`.
class Success<L, R> extends Either<L, R> {
  final R value;
  const Success(this.value);

  /// Static convenience method for creating a success result with custom type
  /// Useful for creating a success result without having to specify the type
  static Either<GenericError, T> of<T>(T value) => Success<GenericError, T>(value);

  @override
  T fold<T>(T Function(L) ifLeft, T Function(R) ifRight) => ifRight(value);

  @override
  R getOrElse(R defaultValue) => value;

  @override
  Either<L, T> map<T>(T Function(R) f) => Success<L, T>(f(value));

  @override
  Either<L, T> flatMap<T>(Either<L, T> Function(R) f) => f(value);
}
