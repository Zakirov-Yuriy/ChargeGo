import 'package:flutter/foundation.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/logger.dart';

class PaymentState extends ChangeNotifier {
  // Loading states
  bool _isInitializing = false;
  bool _isProcessingPayment = false;
  bool _isLoadingBraintreeToken = false;

  // Data
  String? _braintreeToken;
  Failure? _error;

  // Getters
  bool get isInitializing => _isInitializing;
  bool get isProcessingPayment => _isProcessingPayment;
  bool get isLoadingBraintreeToken => _isLoadingBraintreeToken;
  String? get braintreeToken => _braintreeToken;
  Failure? get error => _error;

  // Computed properties
  bool get hasError => _error != null;
  bool get isLoading => _isInitializing || _isProcessingPayment || _isLoadingBraintreeToken;

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Set initializing state
  void setInitializing(bool value) {
    _isInitializing = value;
    if (value) {
      _error = null; // Clear error when starting
    }
    notifyListeners();
  }

  // Set processing payment state
  void setProcessingPayment(bool value) {
    _isProcessingPayment = value;
    if (value) {
      _error = null; // Clear error when starting
    }
    notifyListeners();
  }

  // Set loading Braintree token state
  void setLoadingBraintreeToken(bool value) {
    _isLoadingBraintreeToken = value;
    if (value) {
      _error = null; // Clear error when starting
    }
    notifyListeners();
  }

  // Set Braintree token
  void setBraintreeToken(String? token) {
    _braintreeToken = token;
    notifyListeners();
  }

  // Set error
  void setError(Failure failure) {
    _error = failure;
    logE('Payment error: ${failure.message}');
    notifyListeners();
  }

  // Reset state
  void reset() {
    _isInitializing = false;
    _isProcessingPayment = false;
    _isLoadingBraintreeToken = false;
    _braintreeToken = null;
    _error = null;
    notifyListeners();
  }

  @override
  String toString() {
    return 'PaymentState('
        'isInitializing: $_isInitializing, '
        'isProcessingPayment: $_isProcessingPayment, '
        'isLoadingBraintreeToken: $_isLoadingBraintreeToken, '
        'hasToken: ${_braintreeToken != null}, '
        'hasError: $hasError'
        ')';
  }
}
