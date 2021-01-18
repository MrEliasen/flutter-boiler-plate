import 'package:flutter_app_boilerplate/infrastructure/core/error_handler.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';
import 'package:hive/hive.dart';

class SessionHive {
  LazyBox<User> _box;

  /// Keep the same instance alive
  static SessionHive _instance;

  /// Keep the same instance alive
  factory SessionHive() => _instance ??= SessionHive._();
  SessionHive._();

  Future open() async {
    _box = await Hive.openLazyBox<User>('session');
  }

  void save(User user) {
    try {
      _box.put('session', user);
    } catch (error, stackTrace) {
      ErrorHandler().logException(error, stackTrace);
    }
  }

  Future<User> get() async {
    try {
      return _box.get('session');
    } catch (error, stackTrace) {
      ErrorHandler().logException(error, stackTrace);
      return null;
    }
  }

  void clear() {
    try {
      _box.clear();
    } catch (error, stackTrace) {
      ErrorHandler().logException(error, stackTrace);
    }
  }
}
