/// App-wide constants for AutoHub Express.
abstract final class AppConstants {
  /// The application display name.
  static const String appName = 'AutoHub Express';

  /// Base URL for the API (loaded from .env at runtime).
  static const String baseUrlKey = 'BASE_URL';

  /// Default HTTP connect timeout in milliseconds.
  static const int connectTimeoutMs = 10000;

  /// Default HTTP receive timeout in milliseconds.
  static const int receiveTimeoutMs = 15000;

  /// Free shipping threshold in USD.
  static const double freeShippingThreshold = 100;

  /// Support phone number.
  static const String supportPhone = '+1 (609) 758 1919';

  /// Support email address.
  static const String supportEmail = 'hello@autohub.express';

  /// Business address.
  static const String businessAddress =
      '242 Monmouth Rd, Wrightstown, NJ 08562';
}
