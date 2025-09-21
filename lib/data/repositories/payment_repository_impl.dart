import 'package:dartz/dartz.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/remote/api_client.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiClient _apiClient;

  const PaymentRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, String>> getBraintreeToken() async {
    try {
      final endpoint = '${ApiConstants.apiVersion}/${ApiConstants.payments}/${ApiConstants.braintreeToken}';
      final response = await _apiClient.post(endpoint);

      if (response is Map<String, dynamic> && response['clientToken'] != null) {
        return Right(response['clientToken']);
      } else {
        return Left(ServerFailure(message: 'Неверный ответ сервера'));
      }
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> createSubscription(String paymentToken) async {
    try {
      final endpoint = '${ApiConstants.apiVersion}/${ApiConstants.payments}/${ApiConstants.createSubscription}';
      final body = {
        'paymentToken': paymentToken,
        'thePlanId': ApiConstants.planId,
        'disableWelcomeDiscount': ApiConstants.disableWelcomeDiscount,
        'welcomeDiscount': ApiConstants.welcomeDiscount,
      };

      final response = await _apiClient.post(endpoint, body: body);

      if (response is Map<String, dynamic> && response['success'] == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: 'Ошибка создания подписки'));
      }
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> rentPowerBank(String stationId) async {
    try {
      final endpoint = '${ApiConstants.apiVersion}/${ApiConstants.payments}/${ApiConstants.rentPowerBank}';
      final body = {'stationId': stationId};

      final response = await _apiClient.post(endpoint, body: body);

      if (response is Map<String, dynamic> && response['success'] == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: 'Ошибка аренды павербанка'));
      }
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> createAppleAccount() async {
    try {
      final endpoint = '${ApiConstants.apiVersion}/${ApiConstants.auth}/${ApiConstants.appleAuth}';
      final response = await _apiClient.post(endpoint);

      if (response is Map<String, dynamic> && response['success'] == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: 'Ошибка создания аккаунта Apple'));
      }
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> addPaymentMethod(String paymentMethodNonce) async {
    try {
      final endpoint = '${ApiConstants.apiVersion}/${ApiConstants.payments}/${ApiConstants.addPaymentMethod}';
      final body = {'paymentMethodNonce': paymentMethodNonce};

      final response = await _apiClient.post(endpoint, body: body);

      if (response is Map<String, dynamic> && response['success'] == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: 'Ошибка добавления метода оплаты'));
      }
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  // Error handler
  Failure _handleError(dynamic error) {
    if (error is Failure) {
      return error;
    }

    if (error.toString().contains('NetworkFailure')) {
      return NetworkFailure(message: error.toString());
    }

    if (error.toString().contains('ServerFailure')) {
      return ServerFailure(message: error.toString());
    }

    return UnknownFailure(message: error.toString());
  }
}
