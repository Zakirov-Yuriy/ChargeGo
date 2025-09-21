import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/constants/app_constants.dart';

enum ButtonVariant {
  primary,
  secondary,
  success,
  outline,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Button style based on variant
    final ButtonStyle style = _getButtonStyle(theme);

    // Button size
    final buttonHeight = _getButtonHeight();
    final fontSize = _getFontSize();
    final iconSize = _getIconSize();

    return SizedBox(
      width: width ?? double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: _buildButtonContent(fontSize, iconSize),
      ),
    );
  }

  Widget _buildButtonContent(double fontSize, double iconSize) {
    if (isLoading) {
      return SizedBox(
        height: iconSize,
        width: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getTextColor(),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          SizedBox(width: UIConstants.spacingS),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: UIConstants.spacingS),
          trailingIcon!,
        ],
      ],
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    final baseStyle = theme.elevatedButtonTheme.style ?? ElevatedButton.styleFrom();

    switch (variant) {
      case ButtonVariant.primary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.black),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        );

      case ButtonVariant.secondary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
          foregroundColor: WidgetStateProperty.all(Colors.black),
        );

      case ButtonVariant.success:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Color(UIConstants.primaryGreen)),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        );

      case ButtonVariant.outline:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Colors.black),
          side: WidgetStateProperty.all(
            BorderSide(color: Colors.grey.shade300),
          ),
        );

      // Все варианты покрыты выше
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return Colors.black;
      case ButtonVariant.success:
        return Colors.white;
      case ButtonVariant.outline:
        return Colors.black;
      // Все варианты покрыты выше
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return UIConstants.buttonHeightS;
      case ButtonSize.medium:
        return UIConstants.buttonHeightM;
      case ButtonSize.large:
        return UIConstants.buttonHeightL;
      // Все варианты покрыты выше
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return UIConstants.fontSizeM;
      case ButtonSize.medium:
        return UIConstants.fontSizeL;
      case ButtonSize.large:
        return UIConstants.fontSizeXL;
      // Все варианты покрыты выше
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
      // Все варианты покрыты выше
    }
  }
}
