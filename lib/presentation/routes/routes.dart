import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/presentation/widgets/splash_screen/splash_screen.dart';
import 'package:flutter_app_boilerplate/presentation/widgets/welcome/welcome.dart';
import 'package:flutter_app_boilerplate/settings.dart';

/// The map containing all named routes.
Map<String, Function> routes = <String, Function>{
  SplashScreen.routeName: SplashScreen.routeTransition,
  Welcome.routeName: Welcome.routeTransition,
};

/// Generates the [PageRouteBuilder] for the provided [widget].
Function namedRouteBuilder(
  Widget widget, {
  Duration duration,
  RouteTransitionsBuilder transition,
}) {
  const defaultTransition = Settings.defaultTransitionAnimation;
  const defaultDuration = Duration(
    milliseconds: Settings.defaultTransitionDuration,
  );

  return (RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        },
        transitionDuration: duration ?? defaultDuration,
        transitionsBuilder: transition ?? defaultTransition,
      );
}
