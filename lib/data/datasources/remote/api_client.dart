import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/retry_helper.dart';

class ApiClient {
  final http.Client _client = http.Client();

  // Base URL
  String get _baseUrl => ApiConstants.baseUrl;

  // Headers
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
      };

  // GET request with retry
  Future<dynamic> get(String endpoint) async {
    return RetryHelper.retryApiOperation(
      () async {
        final response = await _client
            .get(Uri.parse('$_baseUrl/$endpoint'), headers: _headers)
            .timeout(AppConfig.apiTimeout);

        return _handleResponse(response);
      },
      operationName: 'GET $endpoint',
    );
  }

  // POST request with retry
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    return RetryHelper.retryApiOperation(
      () async {
        final response = await _client
            .post(
              Uri.parse('$_baseUrl/$endpoint'),
              headers: _headers,
              body: body != null ? json.encode(body) : null,
            )
            .timeout(AppConfig.apiTimeout);

        return _handleResponse(response);
      },
      operationName: 'POST $endpoint',
    );
  }

  // Response handler
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      // Success
      if (responseBody.isEmpty) return true;

      try {
        return json.decode(responseBody);
      } catch (e) {
        throw ValidationFailure(message: 'Ошибка парсинга ответа');
      }
    } else {
      // Error
      String message = 'Ошибка сервера';

      try {
        final errorData = json.decode(responseBody);
        message = errorData['message'] ?? 'Неизвестная ошибка';
      } catch (e) {
        // Use default message
      }

      throw ServerFailure(
        message: message,
        code: statusCode.toString(),
      );
    }
  }

  // Dispose
  void dispose() {
    _client.close();
  }
}
