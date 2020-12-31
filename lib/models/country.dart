import 'package:flutter_app_boilerplate/core/app_helper.dart';

class Country {
  String isoCode;
  String name;
  int countryCode;

  Country({
    this.isoCode,
    this.name,
    this.countryCode,
  });

  factory Country.fromMap(Map<String, dynamic> data) {
    return Country(
      isoCode: AppHelper.getString(data['isoCode']),
      name: AppHelper.getString(data['name']),
      countryCode: AppHelper.getInt(data['countryCode']),
    );
  }

  /// Returns a map export of the [User] instance.
  Map<String, dynamic> toMap() {
    return {
      'isoCode': isoCode,
      'name': name,
      'countryCode': countryCode,
    };
  }
}
