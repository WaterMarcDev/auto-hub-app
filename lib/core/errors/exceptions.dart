/// Custom exception classes for the application.
///
/// Exceptions are thrown in the data layer and caught by repositories,
/// which convert them into Failure types for the domain layer.
library;

/// Exception thrown when a server/API call fails.
class ServerException implements Exception {
  const ServerException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException(message: $message, '
      'statusCode: $statusCode)';
}

/// Exception thrown when a local cache operation fails.
class CacheException implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  String toString() => 'CacheException(message: $message)';
}

/// Exception thrown when there is no network connectivity.
class NetworkException implements Exception {
  const NetworkException({
    this.message = 'No internet connection.',
  });

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}
