import 'package:flutter/material.dart';

class AppSafeArea {
  final EdgeInsets padding;

  /// The current instance
  static AppSafeArea _instance;

  /// create a new instance or fetch the old one
  factory AppSafeArea({EdgeInsets offset}) {
    if (_instance != null) {
      return _instance;
    }

    return _instance = AppSafeArea._(padding: offset);
  }

  AppSafeArea._({this.padding});

  double get totalHeight {
    return padding.top + padding.bottom;
  }
}
