import 'package:equatable/equatable.dart';

/// Base failure class for the application.
///
/// All domain-layer failures should extend this class.
/// Used with `Either<Failure, T>` from fpdart.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  /// Human-readable error message.
  final String message;

  /// Optional HTTP status code associated with the failure.
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure originating from a remote server/API call.
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Failure originating from local cache/storage operations.
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Failure due to no network connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
  });
}

/// Failure for unexpected/unknown errors.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred. Please try again.',
  });
}
