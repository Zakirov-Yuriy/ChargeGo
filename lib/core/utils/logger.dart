import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  const Logger._();

  static const String _appTag = 'RechargeCity';

  // Debug logging
  static void d(String message, {String? tag}) {
    _log(message, level: LogLevel.debug, tag: tag);
  }

  // Info logging
  static void i(String message, {String? tag}) {
    _log(message, level: LogLevel.info, tag: tag);
  }

  // Warning logging
  static void w(String message, {String? tag}) {
    _log(message, level: LogLevel.warning, tag: tag);
  }

  // Error logging
  static void e(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(message, level: LogLevel.error, tag: tag, error: error, stackTrace: stackTrace);
  }

  // API logging
  static void api(String message, {String? endpoint, String? method, int? statusCode}) {
    final tag = 'API';
    final apiMessage = [
      if (method != null) '[$method]',
      if (endpoint != null) endpoint,
      if (statusCode != null) '($statusCode)',
      ': $message'
    ].join(' ');

    _log(apiMessage, level: LogLevel.info, tag: tag);
  }

  // Payment logging
  static void payment(String message, {String? operation, double? amount}) {
    final tag = 'PAYMENT';
    final paymentMessage = [
      if (operation != null) '[$operation]',
      if (amount != null) '\$$amount',
      ': $message'
    ].join(' ');

    _log(paymentMessage, level: LogLevel.info, tag: tag);
  }

  // Performance logging
  static void performance(String operation, Duration duration) {
    final tag = 'PERFORMANCE';
    final message = '$operation took ${duration.inMilliseconds}ms';
    _log(message, level: LogLevel.info, tag: tag);
  }

  // Main logging method
  static void _log(
    String message, {
    required LogLevel level,
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    final logTag = tag ?? 'APP';
    final levelPrefix = _getLevelPrefix(level);

    final logMessage = '[$timestamp] $levelPrefix [$_appTag:$logTag] $message';

    // In debug mode, print to console
    if (kDebugMode) {
      debugPrint(logMessage);

      // Print error details if available
      if (error != null) {
        debugPrint('Error details: $error');
      }

      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }

    // In release mode, you could send logs to analytics service
    // _sendToAnalytics(logMessage, level, error, stackTrace);
  }

  static String _getLevelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
      case LogLevel.warning:
        return '⚠️ WARNING';
      case LogLevel.error:
        return '❌ ERROR';
    }
  }

  // Analytics integration (placeholder) - TODO: Implement analytics logging
  // Example: FirebaseAnalytics.logEvent(name: 'log_event', parameters: {...});
}

// Extension for easy logging in classes
extension LoggerExtension on Object {
  String get _className => runtimeType.toString();

  void logD(String message) => Logger.d(message, tag: _className);
  void logI(String message) => Logger.i(message, tag: _className);
  void logW(String message) => Logger.w(message, tag: _className);
  void logE(String message, {dynamic error, StackTrace? stackTrace}) =>
      Logger.e(message, tag: _className, error: error, stackTrace: stackTrace);
}
