import 'package:flutter_app_boilerplate/infrastructure/core/helper.dart';

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
      isoCode: Helper.getString(data['isoCode']),
      name: Helper.getString(data['name']),
      countryCode: Helper.getInt(data['countryCode']),
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
