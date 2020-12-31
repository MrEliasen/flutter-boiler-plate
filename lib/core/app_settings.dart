class AppSettings {
  static const String _productionApiUrl = "https://api.prod.flutterapp.tld";
  static const String _developmentApiUrl = "https://api.dev.flutterapp.tld";
  static const String sentryUrl = "";

  /// returns true if the app is in debug/development mode.
  static bool get isInDebugMode {
    // Assume you're in production mode.
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
  }

  /// returns the api base url based on [isInDebugMode]
  static String get apiBaseUrl {
    if (isInDebugMode) {
      return _developmentApiUrl;
    }

    return _productionApiUrl;
  }
}
