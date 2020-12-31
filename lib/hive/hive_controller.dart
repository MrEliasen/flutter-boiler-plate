import 'package:flutter_app_boilerplate/hive/adaptors/user_adapter.dart';
import 'package:flutter_app_boilerplate/hive/hives/hive_session.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveController {
  HiveSession session;
  Box<String> locale;

  /// Keep the same instance alive
  static HiveController _instance;
  factory HiveController() => _instance ??= HiveController._();
  HiveController._();

  Future init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(UserAdapter());

    session = HiveSession();
    await session.open();
  }
}
