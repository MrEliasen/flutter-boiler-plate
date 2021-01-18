import 'package:flutter_app_boilerplate/repositories/api_requests/location_weather.dart';

class Repository {
  final WeatherApiProvider weather = WeatherApiProvider();

  /// singleton instance
  static Repository _instance;

  /// Get the instance or create a new one if one has not been made already
  factory Repository() {
    if (_instance != null) {
      return _instance;
    }

    return _instance = Repository._();
  }

  Repository._();
}
