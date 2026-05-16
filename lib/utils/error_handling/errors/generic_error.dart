/// Abstract base class for all errors in the application.
///
/// This class provides a foundation for a type-safe error handling strategy,
/// especially when using functional patterns like `Either`. Instead of throwing
/// exceptions, operations that might fail return an instance of a concrete
/// `GenericError` subclass wrapped in a `Failure` part of an `Either` type.
///
/// Each module can extend this class to create domain-specific error types
/// while maintaining consistency across the application.
abstract class GenericError {
  const GenericError();
}
