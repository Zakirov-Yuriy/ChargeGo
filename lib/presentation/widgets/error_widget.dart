import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/error_handler.dart';

class CustomErrorWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;
  final String? customMessage;
  final bool showRetryButton;

  const CustomErrorWidget({
    super.key,
    required this.failure,
    this.onRetry,
    this.customMessage,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final message = customMessage ?? ErrorHandler.getUserFriendlyMessage(failure);

    return Container(
      padding: const EdgeInsets.all(UIConstants.spacingL),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade600,
                size: 24,
              ),
              const SizedBox(width: UIConstants.spacingS),
              Expanded(
                child: Text(
                  'Ошибка',
                  style: TextStyle(
                    fontSize: UIConstants.fontSizeL,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade800,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: UIConstants.spacingM),
          Text(
            message,
            style: TextStyle(
              fontSize: UIConstants.fontSizeM,
              color: Colors.red.shade700,
              fontFamily: 'Inter',
            ),
          ),
          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: UIConstants.spacingL),
            SizedBox(
              width: double.infinity,
              height: UIConstants.buttonHeightM,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Попробовать снова'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Простая версия для отображения строкового сообщения об ошибке
class SimpleErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const SimpleErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacingL),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade600,
            size: 20,
          ),
          const SizedBox(width: UIConstants.spacingS),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: UIConstants.fontSizeM,
                color: Colors.red.shade700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          if (onRetry != null)
            IconButton(
              onPressed: onRetry,
              icon: Icon(
                Icons.refresh,
                color: Colors.red.shade600,
                size: 20,
              ),
              tooltip: 'Попробовать снова',
            ),
        ],
      ),
    );
  }
}

// SnackBar для отображения ошибок
class ErrorSnackBar {
  static void show(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: UIConstants.spacingS),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Inter',
                ),
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry();
                },
                child: const Text(
                  'Повторить',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
        ),
      ),
    );
  }
}
