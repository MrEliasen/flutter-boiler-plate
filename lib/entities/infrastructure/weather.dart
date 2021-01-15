import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/infrastructure/core/helper.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/remote/api/requests/get_location_weather.dart';

/// The weather model used in the [GetWeather] API request
class Weather {
  Weather({
    @required this.id,
    @required this.main,
    @required this.description,
    @required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(dynamic data) {
    final Map<String, dynamic> weather = data as Map<String, dynamic>;

    return Weather(
      id: Helper.getInt(weather['id']),
      main: Helper.getString(weather['id']),
      description: Helper.getString(weather['id']),
      icon: Helper.getString(weather['id']),
    );
  }
}
