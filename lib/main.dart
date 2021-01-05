import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/App.dart';
import 'package:flutter_app_boilerplate/infrastructure/core/error_handler.dart';
import 'package:flutter_app_boilerplate/infrastructure/core/global_navigator.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/device.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/hive/hive_db.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  // make sure the flutter widget bindings are initialised before we continue.
  WidgetsFlutterBinding.ensureInitialized();

  // setup logging output handler and level
  Logger.root.level = kDebugMode ? Level.ALL : Level.OFF;
  Logger.root.onRecord.listen((record) {
    print('(${record.level.name}) :: ${record.message}');
  });

  // create the global nav key for the app, allowing us to navigate without
  // the need for "context"
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // setup Sentry.io and local error handler
  ErrorHandler();
  // Load the global navigator
  GlobalNavigator(navKey);
  // Load the Device
  Device();
  // Load Hive
  await HiveDB().init();

  // Run the whole app in a zone to capture all uncaught errors.
  runZonedGuarded(
    () => runApp(App(navKey)),
    (error, stackTrace) {
      try {
        ErrorHandler().logException(error, stackTrace);
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print(error);
        print(stackTrace);
      }
    },
  );
}
