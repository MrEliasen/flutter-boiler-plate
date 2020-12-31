import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/core/app_error_handler.dart';
import 'package:flutter_app_boilerplate/hive/hive_controller.dart';
import 'package:logging/logging.dart';

import 'app.dart';

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
  AppErrorHandler();
  // Load Hive
  await HiveController().init();

  // Run the whole app in a zone to capture all uncaught errors.
  runZonedGuarded(
    () => runApp(App(navKey)),
    (error, stackTrace) {
      try {
        AppErrorHandler().logException(error, stackTrace);
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
