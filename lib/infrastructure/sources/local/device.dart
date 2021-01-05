import 'package:location/location.dart';
import 'package:package_info/package_info.dart';

class Device {
  /// holds the [Location] instance
  Location _gps;

  /// [PackageInfo] instance
  PackageInfo _package;

  /// [Device] singleton instance
  static Device _instance;

  /// Get the instanace or create a new one if one has not been made already
  factory Device() {
    if (_instance != null) {
      return _instance;
    }

    return _instance = Device._();
  }

  Device._();

  /// Populate the instance with its requires dependencies
  Future init() async {
    _package = await PackageInfo.fromPlatform();
  }

  /// Gets the current location of the user.
  ///
  /// Throws an error if the app has no permission to access location.
  /// Returns a [LocationData] object.
  Future<LocationData> get location async {
    return _gps.getLocation();
  }

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  String get appVersion {
    return _package.version;
  }

  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  String get appName {
    return _package.appName;
  }

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  String get appbuildNumber {
    return _package.buildNumber;
  }

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  String get appPackageName {
    return _package.packageName;
  }
}
