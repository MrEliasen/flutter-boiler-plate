class Helper {
  /// Converts and asserts the [value] as if it was a boolean
  static bool getBool(dynamic value) {
    bool _returnValue = false;

    /// check for null values
    if (value == null) {
      return false;
    }

    /// check for [bool] types
    if (value is bool) {
      return value;
    }

    /// check for [String] types
    if (value is String) {
      switch (value.toLowerCase()) {
        case '1':
        case 'true':
        case 'yes':
          _returnValue = true;
          break;
      }

      return _returnValue;
    }

    /// check for [int] types
    if (value is int) {
      return value >= 1;
    }

    /// check for [double] types
    if (value is double) {
      return value > 0;
    }

    /// return default value if non of the above
    return _returnValue;
  }

  /// Converts [value] to a double, returns 0.0 on failure or unconverteble value.
  static double getDouble(dynamic value, {bool nullDefault = false}) {
    /// check for null values
    if (value == null) {
      return nullDefault ? null : 0.0;
    }

    /// check for [double] types
    if (value is double) {
      return value;
    }

    /// check for [int] types
    if (value is int) {
      return value.toDouble();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return double.parse(value);
        } catch (error) {
          // do nothing, this value is not parse-able.
        }
      }
    }

    return nullDefault ? null : 0.0;
  }

  /// Converts [value] to an int, returns 0 on failure or unconverteble value.
  static int getInt(dynamic value, {bool nullDefault = false}) {
    /// check for null values
    if (value == null) {
      return nullDefault ? null : 0;
    }

    /// check for [int] types
    if (value is int) {
      return value;
    }

    /// check for [double] types
    if (value is double) {
      return value.toInt();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return int.parse(value);
        } catch (error) {
          // re assume this means the value is actually a double, as a string.
          return getInt(double.parse(value), nullDefault: nullDefault);
        }
      }
    }

    return nullDefault ? null : 0;
  }

  /// Parses the [value] as a string. If the value is a Map or List, it will
  /// use the first index, returns '' on failure or error.
  static String getString(dynamic value, {bool nullDefault = false}) {
    /// check for null values
    if (value == null) {
      return nullDefault ? null : '';
    }

    /// check for [String] types
    if (value is String) {
      return value;
    }

    /// check for [int] and [double] types
    if (value is int || value is double) {
      return value.toString();
    }

    /// check for [Map] type
    if (value is Map || value is List) {
      if (value.length == 0) {
        return '';
      }

      return Helper.getString(value[0], nullDefault: nullDefault);
    }

    return nullDefault ? null : '';
  }

  /// Parses the [value] as a list of string values. If [lowerCase] is true,
  /// the values with be lower cased.
  static List<String> getStringList(dynamic value, {bool lowerCase = false}) {
    /// check for null values
    if (value == null) {
      return <String>[];
    }

    /// check for [Map] type
    if (value is Map || value is List) {
      if (value.length == 0) {
        return <String>[];
      }

      final List<dynamic> listValue = value as List<dynamic>;

      final List<String> _items = [];
      for (final dynamic str in listValue) {
        String newStr = Helper.getString(str);

        if (lowerCase == true) {
          newStr = newStr.toLowerCase();
        }

        _items.add(newStr);
      }

      return _items;
    }

    /// check for [String] types
    if (value is String) {
      String str = Helper.getString(value);

      if (lowerCase == true) {
        str = value.toLowerCase();
      }

      return <String>[str];
    }

    /// check for [int] and [double] types
    if (value is int || value is double) {
      return <String>[value.toString()];
    }

    return <String>[];
  }
}
