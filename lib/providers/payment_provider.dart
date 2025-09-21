import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initializePayment() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Инициализация платежной системы
      await ApiService.getBraintreeClientToken();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> processPayment(String paymentToken) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.createSubscription(paymentToken);
      if (response.success) {
        return true;
      } else {
        _error = response.message;
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
