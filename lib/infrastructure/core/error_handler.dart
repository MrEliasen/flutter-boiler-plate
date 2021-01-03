import 'package:flutter_app_boilerplate/settings.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

class ErrorHandler {
  SentryClient _sentry;

  /// Keep the same instance alive
  static ErrorHandler _instance;
  factory ErrorHandler() {
    if (_instance != null) {
      return _instance;
    }

    return _instance = ErrorHandler._().._init();
  }
  ErrorHandler._();

  void _init() {
    /// create the sentry client instance
    if (Settings.sentryUrl.isNotEmpty) {
      _sentry = SentryClient(
        dsn: Settings.sentryUrl,
      );
    }

    /// setup flutter error handling to use our logger
    FlutterError.onError = (details, {bool forceReport = false}) {
      try {
        logException(details.exception, details.stack);
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
      } finally {
        // Also use Flutter's pretty error logging to the device's console.
        FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      }
    };
  }

  /// log exception to console, or send to sentry if not in debug mode
  Future<void> logException(dynamic error, dynamic stackTrace) async {
    if (Settings.isInDebugMode) {
      // Print the exception to the console.
      // Print the full stacktrace in debug mode.
      print('Caught error: $error');
      print(stackTrace);
    } else {
      if (_sentry != null) {
        // Send the Exception and Stacktrace to Sentry in Production mode.
        _sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
