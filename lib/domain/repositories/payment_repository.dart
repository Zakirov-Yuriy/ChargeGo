import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

abstract class PaymentRepository {
  // Получить Braintree токен
  Future<Either<Failure, String>> getBraintreeToken();

  // Создать подписку
  Future<Either<Failure, bool>> createSubscription(String paymentToken);

  // Арендовать павербанк
  Future<Either<Failure, bool>> rentPowerBank(String stationId);

  // Создать аккаунт Apple
  Future<Either<Failure, bool>> createAppleAccount();

  // Добавить метод оплаты
  Future<Either<Failure, bool>> addPaymentMethod(String paymentMethodNonce);
}
