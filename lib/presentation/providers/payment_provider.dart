import 'package:flutter/foundation.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/logger.dart';
import '../../domain/use_cases/create_subscription.dart';
import '../../domain/use_cases/get_braintree_token.dart';
import '../../domain/use_cases/rent_power_bank.dart';
import 'payment_state.dart';

class PaymentProvider extends ChangeNotifier {
  final GetBraintreeToken _getBraintreeToken;
  final CreateSubscription _createSubscription;
  final RentPowerBank _rentPowerBank;
  final PaymentState _state;

  PaymentProvider({
    required GetBraintreeToken getBraintreeToken,
    required CreateSubscription createSubscription,
    required RentPowerBank rentPowerBank,
    required PaymentState state,
  })  : _getBraintreeToken = getBraintreeToken,
        _createSubscription = createSubscription,
        _rentPowerBank = rentPowerBank,
        _state = state;

  // Getters for state
  bool get isInitializing => _state.isInitializing;
  bool get isProcessingPayment => _state.isProcessingPayment;
  bool get isLoadingBraintreeToken => _state.isLoadingBraintreeToken;
  bool get isLoading => _state.isLoading;
  bool get hasError => _state.hasError;
  String? get braintreeToken => _state.braintreeToken;
  Failure? get error => _state.error;

  // Initialize payment system
  Future<void> initializePayment() async {
    logI('Initializing payment system');
    _state.setInitializing(true);

    try {
      final result = await _getBraintreeToken();

      result.fold(
        (failure) {
          logE('Failed to get Braintree token: ${failure.message}');
          _state.setError(failure);
        },
        (token) {
          logI('Successfully got Braintree token');
          _state.setBraintreeToken(token);
        },
      );
    } catch (e) {
      logE('Unexpected error during initialization: $e');
      _state.setError(UnknownFailure(message: 'Неожиданная ошибка: $e'));
    } finally {
      _state.setInitializing(false);
    }
  }

  // Process payment
  Future<bool> processPayment(String paymentToken) async {
    logI('Processing payment');
    _state.setProcessingPayment(true);

    try {
      final result = await _createSubscription(paymentToken);

      return result.fold(
        (failure) {
          logE('Payment failed: ${failure.message}');
          _state.setError(failure);
          return false;
        },
        (success) {
          logI('Payment successful');
          return success;
        },
      );
    } catch (e) {
      logE('Unexpected error during payment: $e');
      _state.setError(UnknownFailure(message: 'Неожиданная ошибка: $e'));
      return false;
    } finally {
      _state.setProcessingPayment(false);
    }
  }

  // Rent power bank
  Future<bool> rentPowerBank(String stationId) async {
    logI('Renting power bank for station: $stationId');
    _state.setProcessingPayment(true);

    try {
      final result = await _rentPowerBank(stationId);

      return result.fold(
        (failure) {
          logE('Failed to rent power bank: ${failure.message}');
          _state.setError(failure);
          return false;
        },
        (success) {
          logI('Successfully rented power bank');
          return success;
        },
      );
    } catch (e) {
      logE('Unexpected error during rental: $e');
      _state.setError(UnknownFailure(message: 'Неожиданная ошибка: $e'));
      return false;
    } finally {
      _state.setProcessingPayment(false);
    }
  }

  // Load Braintree token separately
  Future<void> loadBraintreeToken() async {
    logI('Loading Braintree token');
    _state.setLoadingBraintreeToken(true);

    try {
      final result = await _getBraintreeToken();

      result.fold(
        (failure) {
          logE('Failed to load Braintree token: ${failure.message}');
          _state.setError(failure);
        },
        (token) {
          logI('Successfully loaded Braintree token');
          _state.setBraintreeToken(token);
        },
      );
    } catch (e) {
      logE('Unexpected error loading token: $e');
      _state.setError(UnknownFailure(message: 'Неожиданная ошибка: $e'));
    } finally {
      _state.setLoadingBraintreeToken(false);
    }
  }

  // Clear error
  void clearError() {
    _state.clearError();
  }

  // Reset state
  void reset() {
    logI('Resetting payment state');
    _state.reset();
  }

  @override
  String toString() {
    return 'PaymentProvider(state: ${_state.toString()})';
  }
}
