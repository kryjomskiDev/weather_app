import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

extension EitherExtension<L extends GenericError, R> on Either<L, R> {
  /// Extracts the value from an `Either` instance, returning `null` if it's a `Failure`.
  R? extractValueOrNull() => fold((L error) => null, (R value) => value);
}
