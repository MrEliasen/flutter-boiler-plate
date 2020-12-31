import 'package:flutter_app_boilerplate/core/app_error_handler.dart';
import 'package:flutter_app_boilerplate/models/user.dart';
import 'package:hive/hive.dart';

class HiveSession {
  LazyBox<User> _box;

  /// Keep the same instance alive
  static HiveSession _instance;

  /// Keep the same instance alive
  factory HiveSession() => _instance ??= HiveSession._();
  HiveSession._();

  Future open() async {
    _box = await Hive.openLazyBox<User>('session');
  }

  void save(User user) {
    try {
      _box.put('session', user);
    } catch (error, stackTrace) {
      AppErrorHandler().logException(error, stackTrace);
    }
  }

  Future<User> get() async {
    try {
      return _box.get('session');
    } catch (error, stackTrace) {
      AppErrorHandler().logException(error, stackTrace);
      return null;
    }
  }

  void clear() {
    try {
      _box.clear();
    } catch (error, stackTrace) {
      AppErrorHandler().logException(error, stackTrace);
    }
  }
}
