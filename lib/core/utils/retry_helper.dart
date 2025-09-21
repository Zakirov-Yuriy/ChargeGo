import 'dart:async';
import '../errors/failures.dart';
import 'logger.dart';

class RetryHelper {
  const RetryHelper._();

  /// Retry configuration
  static const int defaultMaxAttempts = 3;
  static const Duration defaultDelay = Duration(seconds: 1);
  static const Duration defaultMaxDelay = Duration(seconds: 10);

  /// Retry a function with exponential backoff
  static Future<T> retry<T>(
    Future<T> Function() operation, {
    int maxAttempts = defaultMaxAttempts,
    Duration delay = defaultDelay,
    Duration maxDelay = defaultMaxDelay,
    bool Function(Failure)? shouldRetry,
    String operationName = 'operation',
  }) async {
    int attempt = 0;
    Failure? lastFailure;

    while (attempt < maxAttempts) {
      attempt++;

      try {
        if (attempt > 1) {
          Logger.i('Retrying $operationName (attempt $attempt/$maxAttempts)');
        }

        final result = await operation();

        if (attempt > 1) {
          Logger.i('Successfully completed $operationName after $attempt attempts');
        }

        return result;
      } catch (e) {
        lastFailure = e is Failure ? e : UnknownFailure(message: e.toString());

        Logger.w(
          'Attempt $attempt/$maxAttempts failed for $operationName: ${lastFailure.message}',
        );

        // Check if we should retry
        if (attempt >= maxAttempts || (shouldRetry != null && !shouldRetry(lastFailure))) {
          Logger.e('All retry attempts exhausted for $operationName');
          rethrow;
        }

        // Wait before next attempt
        await _waitBeforeRetry(attempt, delay, maxDelay);
      }
    }

    throw lastFailure ?? UnknownFailure(message: 'Retry failed');
  }

  /// Retry with default settings for network operations
  static Future<T> retryNetworkOperation<T>(
    Future<T> Function() operation, {
    String operationName = 'network operation',
  }) async {
    return retry(
      operation,
      maxAttempts: 3,
      delay: const Duration(seconds: 1),
      shouldRetry: (failure) => failure is NetworkFailure,
      operationName: operationName,
    );
  }

  /// Retry with default settings for API operations
  static Future<T> retryApiOperation<T>(
    Future<T> Function() operation, {
    String operationName = 'API operation',
  }) async {
    return retry(
      operation,
      maxAttempts: 2,
      delay: const Duration(milliseconds: 500),
      shouldRetry: (failure) => failure is NetworkFailure || failure is ServerFailure,
      operationName: operationName,
    );
  }

  /// Wait before retry with exponential backoff
  static Future<void> _waitBeforeRetry(int attempt, Duration baseDelay, Duration maxDelay) async {
    final delay = _calculateDelay(attempt, baseDelay, maxDelay);
    Logger.d('Waiting ${delay.inMilliseconds}ms before retry attempt $attempt');
    await Future.delayed(delay);
  }

  /// Calculate delay with exponential backoff and jitter
  static Duration _calculateDelay(int attempt, Duration baseDelay, Duration maxDelay) {
    final exponentialDelay = baseDelay * (1 << (attempt - 1)); // 2^(attempt-1)
    final jitteredDelay = exponentialDelay + Duration(milliseconds: _randomJitter());

    return jitteredDelay > maxDelay ? maxDelay : jitteredDelay;
  }

  /// Add random jitter to prevent thundering herd
  static int _randomJitter() {
    return DateTime.now().microsecondsSinceEpoch % 1000; // 0-999ms jitter
  }

  /// Retry configuration for different types of operations
  static const RetryConfig networkConfig = RetryConfig(
    maxAttempts: 3,
    baseDelay: Duration(seconds: 1),
    maxDelay: Duration(seconds: 10),
    shouldRetry: _shouldRetryNetwork,
  );

  static const RetryConfig apiConfig = RetryConfig(
    maxAttempts: 2,
    baseDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 5),
    shouldRetry: _shouldRetryApi,
  );

  static bool _shouldRetryNetwork(Failure failure) => failure is NetworkFailure;

  static bool _shouldRetryApi(Failure failure) =>
      failure is NetworkFailure || failure is ServerFailure;
}

/// Configuration class for retry operations
class RetryConfig {
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;
  final bool Function(Failure) shouldRetry;

  const RetryConfig({
    required this.maxAttempts,
    required this.baseDelay,
    required this.maxDelay,
    required this.shouldRetry,
  });
}
