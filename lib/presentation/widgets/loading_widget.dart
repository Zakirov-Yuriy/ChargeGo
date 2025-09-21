import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.message,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size ?? 40,
            width: size ?? 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: UIConstants.spacingM),
            Text(
              message!,
              style: TextStyle(
                fontSize: UIConstants.fontSizeM,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// Центрированный загрузчик для всего экрана
class FullScreenLoading extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;

  const FullScreenLoading({
    super.key,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      child: Center(
        child: LoadingWidget(
          message: message,
          size: 50,
        ),
      ),
    );
  }
}

// Линейный индикатор загрузки
class LinearLoadingWidget extends StatelessWidget {
  final double? value;
  final String? message;
  final Color? backgroundColor;
  final Color? valueColor;

  const LinearLoadingWidget({
    super.key,
    this.value,
    this.message,
    this.backgroundColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.spacingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: value,
            backgroundColor: backgroundColor ?? Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              valueColor ?? Theme.of(context).primaryColor,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: UIConstants.spacingS),
            Text(
              message!,
              style: TextStyle(
                fontSize: UIConstants.fontSizeS,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// Кнопка с состоянием загрузки
class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonStyle? style;
  final double? width;
  final double? height;

  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.style,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? UIConstants.buttonHeightM,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}) ??
                    Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: UIConstants.fontSizeL,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
      ),
    );
  }
}
