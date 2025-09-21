// API Configuration
class ApiConstants {
  static const String baseUrl = 'https://goldfish-app-3lf7u.ondigitalocean.app';
  static const String apiVersion = 'v1';

  // Endpoints
  static const String auth = 'auth';
  static const String payments = 'payments';
  static const String subscription = 'subscription';
  static const String rentPowerBank = 'rent-power-bank';

  // Apple Auth
  static const String appleAuth = 'apple/generate-account';

  // Braintree
  static const String braintreeToken = 'generate-and-save-braintree-client-token';

  // Payment Methods
  static const String addPaymentMethod = 'add-payment-method';
  static const String createSubscription = 'subscription/create-subscription-transaction-v2';

  // Subscription
  static const String planId = 'tss2';
  static const bool disableWelcomeDiscount = false;
  static const int welcomeDiscount = 10;
}

// UI Constants
class UIConstants {
  // Colors
  static const int primaryGreen = 0xFF1EE300;
  static const int gradientStart = 0xFFF9FD57;
  static const int gradientMiddle1 = 0xFFD0FF1D;
  static const int gradientMiddle2 = 0xFF9DFF10;
  static const int gradientEnd = 0xFF70FF02;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 14.0;
  static const double borderRadiusXL = 18.0;

  // Font sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 28.0;
  static const double fontSizeXXXL = 38.0;
  static const double fontSizeXXXXL = 48.0;

  // Button heights
  static const double buttonHeightS = 48.0;
  static const double buttonHeightM = 50.0;
  static const double buttonHeightL = 64.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 250);
  static const Duration animationSlow = Duration(milliseconds: 300);
}

// Payment Constants
class PaymentConstants {
  static const double monthlyPrice = 4.99;
  static const double originalPrice = 9.99;
  static const String currency = '\$';
  static const String firstMonthText = 'First month only';
  static const String monthlySubscription = 'Monthly Subscription';
  static const String payButtonText = 'Pay';
  static const String downloadApp = 'Download App';
  static const String contactSupport = 'Contact support';
  static const String nothingHappened = 'Nothing happened?';
}

// App Configuration
class AppConfig {
  static const String appName = 'Recharge City';
  static const String appTitle = 'recharge.city';
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.recharge.city&hl=ru';
  static const String supportUrl = 'https://play.google.com/store/apps/details?id=com.recharge.city&hl=ru';

  // Timeout settings
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration deepLinkTimeout = Duration(seconds: 10);

  // Retry settings
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 1);
}
