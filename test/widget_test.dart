import 'package:auto_hub_app/core/errors/exceptions.dart';
import 'package:auto_hub_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failures', () {
    test('ServerFailure props include message and statusCode', () {
      const failure = ServerFailure(message: 'Server error', statusCode: 500);

      expect(failure.message, 'Server error');
      expect(failure.statusCode, 500);
      expect(failure.props, ['Server error', 500]);
    });

    test('NetworkFailure has default message', () {
      const failure = NetworkFailure();

      expect(
        failure.message,
        'No internet connection. Please check your network.',
      );
    });

    test('CacheFailure props include message', () {
      const failure = CacheFailure(message: 'Cache miss');

      expect(failure.message, 'Cache miss');
      expect(failure.statusCode, isNull);
    });

    test('UnexpectedFailure has default message', () {
      const failure = UnexpectedFailure();

      expect(
        failure.message,
        'An unexpected error occurred. Please try again.',
      );
    });
  });

  group('Exceptions', () {
    test('ServerException toString includes details', () {
      const exception = ServerException(
        message: 'Not found',
        statusCode: 404,
      );

      expect(
        exception.toString(),
        'ServerException(message: Not found, statusCode: 404)',
      );
    });

    test('CacheException toString includes message', () {
      const exception = CacheException(message: 'Disk full');

      expect(
        exception.toString(),
        'CacheException(message: Disk full)',
      );
    });

    test('NetworkException has default message', () {
      const exception = NetworkException();

      expect(exception.message, 'No internet connection.');
    });
  });
}
