class PaymentToken {
  final String token;
  final String type;

  const PaymentToken({
    required this.token,
    required this.type,
  });

  factory PaymentToken.fromJson(Map<String, dynamic> json) {
    return PaymentToken(
      token: json['token'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'type': type,
    };
  }
}

class SubscriptionRequest {
  final String paymentToken;
  final String thePlanId;

  const SubscriptionRequest({
    required this.paymentToken,
    required this.thePlanId,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentToken': paymentToken,
      'thePlanId': thePlanId,
    };
  }
}

class RentalRequest {
  final String stationId;

  const RentalRequest({
    required this.stationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'stationId': stationId,
    };
  }
}

class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
