import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  // Format currency
  static String formatCurrency(double amount, {String currency = '\$'}) {
    final formatter = NumberFormat.currency(
      symbol: currency,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  // Format card number (add spaces every 4 digits)
  static String formatCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'[^\d]'), '');
    final regex = RegExp(r'\d{4}');
    final matches = regex.allMatches(cleanNumber);

    if (matches.isEmpty) return cleanNumber;

    final formatted = matches.map((match) => match.group(0)).join(' ');
    return formatted;
  }

  // Format expiry date (MM/YY)
  static String formatExpiryDate(String expiry) {
    final cleanExpiry = expiry.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanExpiry.length >= 4) {
      final month = cleanExpiry.substring(0, 2);
      final year = cleanExpiry.substring(2, 4);
      return '$month/$year';
    }

    return cleanExpiry;
  }

  // Format phone number
  static String formatPhoneNumber(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanPhone.length == 11 && cleanPhone.startsWith('7')) {
      // Russian phone number: +7 (XXX) XXX-XX-XX
      return '+7 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7, 9)}-${cleanPhone.substring(9, 11)}';
    } else if (cleanPhone.length == 10) {
      // US phone number: (XXX) XXX-XXXX
      return '(${cleanPhone.substring(0, 3)}) ${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6, 10)}';
    }

    return phone; // Return original if format not recognized
  }

  // Format station ID
  static String formatStationId(String stationId) {
    if (stationId.length == 14 && stationId.startsWith('RECH')) {
      return '${stationId.substring(0, 4)} ${stationId.substring(4, 10)} ${stationId.substring(10, 14)}';
    }
    return stationId;
  }

  // Format date
  static String formatDate(DateTime date, {String pattern = 'dd.MM.yyyy'}) {
    final formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  // Format date and time
  static String formatDateTime(DateTime date, {String pattern = 'dd.MM.yyyy HH:mm'}) {
    final formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  // Format duration
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hoursч $minutesм';
    } else {
      return '$minutesм';
    }
  }

  // Format file size
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var suffixIndex = 0;

    while (size >= 1024 && suffixIndex < suffixes.length - 1) {
      size /= 1024;
      suffixIndex++;
    }

    return '${size.toStringAsFixed(suffixIndex == 0 ? 0 : 1)} ${suffixes[suffixIndex]}';
  }

  // Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Format percentage
  static String formatPercentage(double value, {int decimalPlaces = 1}) {
    return '${(value * 100).toStringAsFixed(decimalPlaces)}%';
  }

  // Remove all whitespace
  static String removeWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }

  // Add thousands separator
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  // Format time ago
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years г. назад';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months мес. назад';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} д. назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ч. назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} мин. назад';
    } else {
      return 'Только что';
    }
  }
}
