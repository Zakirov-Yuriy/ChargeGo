import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/core/errors/error_handler.dart';
import 'package:flutter_application_2/core/errors/failures.dart';

void main() {
  group('ErrorHandler', () {
    group('handleError', () {
      test('should return NetworkFailure for NetworkFailure input', () {
        const failure = NetworkFailure(message: 'Network error');
        final result = ErrorHandler.handleError(failure);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Network error');
      });

      test('should return ServerFailure for ServerFailure input', () {
        const failure = ServerFailure(message: 'Server error');
        final result = ErrorHandler.handleError(failure);

        expect(result, isA<ServerFailure>());
        expect(result.message, 'Server error');
      });

      test('should return ValidationFailure for FormatException input', () {
        const exception = FormatException('Format error');
        final result = ErrorHandler.handleError(exception);

        expect(result, isA<ValidationFailure>());
        expect(result.message, 'Неверный формат данных');
      });

      test('should return ValidationFailure for AssertionError input', () {
        final error = AssertionError('Assertion failed');
        final result = ErrorHandler.handleError(error);

        expect(result, isA<ValidationFailure>());
        expect(result.message, 'Ошибка валидации данных');
      });

      test('should return UnknownFailure for unknown input', () {
        const unknown = 'Some string error';
        final result = ErrorHandler.handleError(unknown);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Произошла неожиданная ошибка');
      });

      test('should return UnknownFailure with custom message', () {
        final exception = StateError('Test error');
        final result = ErrorHandler.handleError(
          exception,
          defaultMessage: 'Custom error message',
        );

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Custom error message');
      });
    });

    group('_handleException', () {
      test('should return NetworkFailure for SocketException', () {
        const exception = SocketException('Connection failed');
        final result = ErrorHandler.handleError(exception);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Отсутствует подключение к интернету');
      });

      test('should return NetworkFailure for TimeoutException', () {
        const exception = TimeoutException('Request timeout');
        final result = ErrorHandler.handleError(exception);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Превышено время ожидания запроса');
      });

      test('should return ValidationFailure for FormatException', () {
        const exception = FormatException('Invalid format');
        final result = ErrorHandler.handleError(exception);

        expect(result, isA<ValidationFailure>());
        expect(result.message, 'Неверный формат данных');
      });

      test('should return UnknownFailure for other exceptions', () {
        final exception = StateError('Invalid state');
        final result = ErrorHandler.handleError(exception);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Bad state: Invalid state');
      });
    });

    group('_handleError', () {
      test('should return ValidationFailure for AssertionError', () {
        final error = AssertionError('Assertion failed');
        final result = ErrorHandler.handleError(error);

        expect(result, isA<ValidationFailure>());
        expect(result.message, 'Ошибка валидации данных');
      });

      test('should return UnknownFailure for other errors', () {
        final error = ArgumentError('Invalid argument');
        final result = ErrorHandler.handleError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Invalid argument(s): Invalid argument');
      });
    });

    group('getUserFriendlyMessage', () {
      test('should return network message for NetworkFailure', () {
        const failure = NetworkFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Проверьте подключение к интернету и попробуйте снова');
      });

      test('should return server message for ServerFailure', () {
        const failure = ServerFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Сервер временно недоступен. Попробуйте позже');
      });

      test('should return auth message for AuthFailure', () {
        const failure = AuthFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Ошибка авторизации. Попробуйте войти заново');
      });

      test('should return validation message for ValidationFailure', () {
        const failure = ValidationFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Проверьте правильность введенных данных');
      });

      test('should return payment message for PaymentFailure', () {
        const failure = PaymentFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Ошибка обработки платежа. Попробуйте другой способ оплаты');
      });

      test('should return custom message for UnknownFailure', () {
        const failure = UnknownFailure(message: 'Custom error');
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Custom error');
      });

      test('should return default message for unknown failure type', () {
        const failure = UnknownFailure();
        final message = ErrorHandler.getUserFriendlyMessage(failure);

        expect(message, 'Неизвестная ошибка');
      });
    });
  });
}

// Mock classes for testing
class SocketException implements Exception {
  final String message;
  const SocketException(this.message);

  @override
  String toString() => 'SocketException: $message';
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}
