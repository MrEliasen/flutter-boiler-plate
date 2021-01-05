import 'package:flutter_app_boilerplate/infrastructure/core/helper.dart';

import '../auth/country.dart';

class User {
  /// hive adaptor id
  static const int adaptorId = 1;

  /// model properties
  String phoneNumber;
  Country country;

  User({
    this.phoneNumber,
    this.country,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      phoneNumber: Helper.getString(data['phoneNumber']),
      country: Country.fromMap(data['country'] as Map<String, dynamic>),
    );
  }

  /// Returns a map export of the [User] instance.
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'country': country.toMap(),
    };
  }

  /// Clones the current [User] instance. Useful when returning an unmodifiable
  /// version from Provider or similar.
  User clone() {
    return User(
      phoneNumber: phoneNumber,
      country: country,
    );
  }
}
