import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/App.dart';
import 'package:flutter_app_boilerplate/infrastructure/core/error_handler.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/hive/hive_db.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  // make sure the flutter widget bindings are initialised before we continue.
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = kDebugMode ? Level.ALL : Level.OFF;
  Logger.root.onRecord.listen((record) {
    print('(${record.level.name}) :: ${record.message}');
  });

  /// https://github.com/brianegan/flutter_redux/issues/5
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // setup Sentry.io and local error handler
  ErrorHandler();
  // Load Hive
  await HiveDB().init();

  // Run the whole app in a zone to capture all uncaught errors.
  runZonedGuarded(
    () => runApp(App(navKey)),
    (error, stackTrace) {
      try {
        ErrorHandler().logException(error, stackTrace);
        print('Error sent to sentry.io: $error');
        print(stackTrace);
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
        print('Stack Trace');
        print(stackTrace);
      }
    },
  );
}
