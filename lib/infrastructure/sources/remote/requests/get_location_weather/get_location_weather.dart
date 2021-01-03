import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/infrastructure/core/helper.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/remote/api_request.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/remote/api_response.dart';
import 'package:http/http.dart';

/// The API request
class GetWeather extends APIRequest {
  Future<_Response> call({String location = "London,uk"}) async {
    final Response response = await get(
      "https://samples.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(location)}&appid=b6907d289e10d714a6e88b30761fae22",
    );
    return _Response(response);
  }
}

/// The API Response
class _Response extends APIResponse {
  _Response(Response response) : super(response) {
    final Map<String, dynamic> main = body['main'] as Map<String, double>;

    /// weather details
    temp = Helper.getDouble(main['temp']);
    tempMin = Helper.getDouble(main['temp_min']);
    tempMax = Helper.getDouble(main['temp_max']);
    pressure = Helper.getDouble(main['pressure']);
    humidity = Helper.getDouble(main['humidity']);
    wind = body['wind'] as Map<String, double>;

    /// location details
    coordinates = body['coord'] as Map<String, double>;
    weather = parseWeather();
  }

  /// weather details
  double temp;
  double tempMin;
  double tempMax;
  double pressure;
  double humidity;
  Map<String, double> wind;

  /// location details
  String name;
  Map<String, double> coordinates;

  /// location weather
  List<_Weather> weather;

  List<_Weather> parseWeather() {
    final List<_Weather> _list = [];

    for (final dynamic weather in body['weather'] as List) {
      _list.add(_Weather.fromJson(weather));
    }

    return _list;
  }
}

/// The weather model used in the response
class _Weather {
  _Weather({
    @required this.id,
    @required this.main,
    @required this.description,
    @required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory _Weather.fromJson(dynamic data) {
    final Map<String, dynamic> weather = data as Map<String, dynamic>;

    return _Weather(
      id: Helper.getInt(weather['id']),
      main: Helper.getString(weather['id']),
      description: Helper.getString(weather['id']),
      icon: Helper.getString(weather['id']),
    );
  }
}
