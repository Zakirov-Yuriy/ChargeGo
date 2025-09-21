import 'package:flutter/foundation.dart';
import 'failures.dart';

class ErrorHandler {
  const ErrorHandler._();

  // Конвертация исключений в Failure
  static Failure handleError(dynamic error, {String? defaultMessage}) {
    if (kDebugMode) {
      debugPrint('ErrorHandler: $error');
    }

    // HTTP ошибки
    if (error is NetworkFailure) {
      return error;
    }

    // Server ошибки
    if (error is ServerFailure) {
      return error;
    }

    // Обработка исключений
    if (error is Exception) {
      return _handleException(error, defaultMessage);
    }

    // Обработка ошибок
    if (error is Error) {
      return _handleError(error, defaultMessage);
    }

    // Неизвестная ошибка
    return UnknownFailure(
      message: defaultMessage ?? 'Произошла неожиданная ошибка',
    );
  }

  static Failure _handleException(Exception exception, String? defaultMessage) {
    // Network exceptions
    if (exception.toString().contains('SocketException') ||
        exception.toString().contains('HandshakeException')) {
      return const NetworkFailure(
        message: 'Отсутствует подключение к интернету',
      );
    }

    if (exception.toString().contains('TimeoutException')) {
      return const NetworkFailure(
        message: 'Превышено время ожидания запроса',
      );
    }

    // Format exceptions
    if (exception.toString().contains('FormatException')) {
      return const ValidationFailure(
        message: 'Неверный формат данных',
      );
    }

    // Default
    return UnknownFailure(
      message: defaultMessage ?? exception.toString(),
    );
  }

  static Failure _handleError(Error error, String? defaultMessage) {
    // Assertion errors
    if (error is AssertionError) {
      return const ValidationFailure(
        message: 'Ошибка валидации данных',
      );
    }

    // Default
    return UnknownFailure(
      message: defaultMessage ?? error.toString(),
    );
  }

  // Получение понятного сообщения для пользователя
  static String getUserFriendlyMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Проверьте подключение к интернету и попробуйте снова';
      case ServerFailure:
        return 'Сервер временно недоступен. Попробуйте позже';
      case AuthFailure:
        return 'Ошибка авторизации. Попробуйте войти заново';
      case ValidationFailure:
        return 'Проверьте правильность введенных данных';
      case PaymentFailure:
        return 'Ошибка обработки платежа. Попробуйте другой способ оплаты';
      case UnknownFailure:
        return failure.message;
      default:
        return 'Произошла неожиданная ошибка';
    }
  }
}
