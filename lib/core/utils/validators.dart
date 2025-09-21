class Validators {
  const Validators._();

  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email не может быть пустым';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Введите корректный email';
    }

    return null;
  }

  // Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Номер телефона не может быть пустым';
    }

    // Remove all non-digit characters
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length < 10 || cleanPhone.length > 15) {
      return 'Номер телефона должен содержать от 10 до 15 цифр';
    }

    return null;
  }

  // Station ID validation
  static String? validateStationId(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID станции не может быть пустым';
    }

    // Station ID format: RECH + 6 digits + 6 digits
    final stationIdRegex = RegExp(r'^RECH\d{6}\d{6}$');
    if (!stationIdRegex.hasMatch(value)) {
      return 'ID станции должен быть в формате RECH123456789012';
    }

    return null;
  }

  // Payment token validation
  static String? validatePaymentToken(String? value) {
    if (value == null || value.isEmpty) {
      return 'Токен платежа не может быть пустым';
    }

    if (value.length < 10) {
      return 'Токен платежа слишком короткий';
    }

    return null;
  }

  // Card number validation (basic)
  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Номер карты не может быть пустым';
    }

    final cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return 'Номер карты должен содержать от 13 до 19 цифр';
    }

    // Luhn algorithm for basic validation
    if (!_isValidLuhn(cleanNumber)) {
      return 'Неверный номер карты';
    }

    return null;
  }

  // Card expiry validation
  static String? validateCardExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Срок действия карты не может быть пустым';
    }

    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    if (!expiryRegex.hasMatch(value)) {
      return 'Срок действия должен быть в формате MM/YY';
    }

    // Check if expiry date is not in the past
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0); // Last day of expiry month

    if (expiryDate.isBefore(now)) {
      return 'Карта просрочена';
    }

    return null;
  }

  // CVC validation
  static String? validateCVC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVC не может быть пустым';
    }

    final cvcRegex = RegExp(r'^\d{3,4}$');
    if (!cvcRegex.hasMatch(value)) {
      return 'CVC должен содержать 3 или 4 цифры';
    }

    return null;
  }

  // Card holder name validation
  static String? validateCardHolder(String? value) {
    if (value == null || value.isEmpty) {
      return 'Имя владельца карты не может быть пустым';
    }

    if (value.length < 2) {
      return 'Имя владельца слишком короткое';
    }

    if (value.length > 50) {
      return 'Имя владельца слишком длинное';
    }

    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Имя владельца содержит недопустимые символы';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    return null;
  }

  // Minimum length validation
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName должен содержать минимум $minLength символов';
    }
    return null;
  }

  // Maximum length validation
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName должен содержать максимум $maxLength символов';
    }
    return null;
  }

  // Luhn algorithm for card number validation
  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}
