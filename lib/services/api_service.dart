import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/payment.dart';

class ApiService {
  static const String baseUrl = 'https://goldfish-app-3lf7u.ondigitalocean.app';

  // Создать аккаунт Apple
  static Future<ApiResponse> createAppleAccount() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/apple/generate-account'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse.fromJson(data);
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to create account: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Error: $e',
      );
    }
  }

  // Получить Braintree токен
  static Future<String?> getBraintreeClientToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/generate-and-save-braintree-client-token'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['clientToken'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Добавить метод оплаты
  static Future<ApiResponse> addPaymentMethod(String paymentMethodNonce) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/add-payment-method'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'paymentMethodNonce': paymentMethodNonce}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse.fromJson(data);
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to add payment method: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Error: $e',
      );
    }
  }

  // Создать подписку
  static Future<ApiResponse> createSubscription(String paymentToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/subscription/create-subscription-transaction-v2?disableWelcomeDiscount=false&welcomeDiscount=10'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'paymentToken': paymentToken,
          'thePlanId': 'tss2',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse.fromJson(data);
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to create subscription: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Error: $e',
      );
    }
  }

  // Арендовать павербанк
  static Future<ApiResponse> rentPowerBank(String stationId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/payments/rent-power-bank'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'stationId': stationId}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse.fromJson(data);
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to rent power bank: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Error: $e',
      );
    }
  }
}
