import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './adaptors/user_adaptor.dart';
import './hives/session_hive.dart';

class HiveDB {
  SessionHive session;
  Box<String> locale;

  /// Keep the same instance alive
  static HiveDB _instance;
  factory HiveDB() => _instance ??= HiveDB._();
  HiveDB._();

  Future init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(UserAdapter());

    session = SessionHive();
    await session.open();
  }
}
