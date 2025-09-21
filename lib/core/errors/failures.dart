// Базовый класс для всех ошибок
abstract class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// Ошибки сети
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Проблема с подключением к сети',
    super.code,
  });
}

// Ошибки сервера
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Ошибка сервера',
    super.code,
  });
}

// Ошибки аутентификации
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Ошибка аутентификации',
    super.code,
  });
}

// Ошибки валидации
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Ошибка валидации данных',
    super.code,
  });
}

// Ошибки платежей
class PaymentFailure extends Failure {
  const PaymentFailure({
    super.message = 'Ошибка обработки платежа',
    super.code,
  });
}

// Неизвестные ошибки
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Неизвестная ошибка',
    super.code,
  });
}
