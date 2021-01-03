import 'package:flutter/cupertino.dart';
import 'package:flutter_app_boilerplate/presentation/routes/route_transitions.dart';

class Settings {
  static const String _productionApiUrl = "https://api.prod.flutterapp.tld";
  static const String _developmentApiUrl = "https://api.dev.flutterapp.tld";
  static const String sentryUrl = "";

  /// duration in ms
  static const int defaultTransitionDuration = 200;

  /// the default animation used when no specific transition is defined for a
  /// named route
  static const RouteTransitionsBuilder defaultTransitionAnimation =
      RouteTransitions.slideToLeft;

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
