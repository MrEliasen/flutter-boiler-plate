import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/presentation/widgets/splash_screen/splash_screen.dart';
import 'package:flutter_app_boilerplate/presentation/widgets/welcome/welcome.dart';
import 'package:flutter_app_boilerplate/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The map containing all named routes.
Map<String, Function> routes = <String, Function>{
  SplashScreen.routeName: SplashScreen.routeTransition,
  Welcome.routeName: Welcome.routeTransition,
};

/// Generates the [PageRouteBuilder] for the provided [widget].
Function namedRouteBuilder({
  @required Widget widget,
  Duration duration,
  RouteTransitionsBuilder transition,
  List<BlocProvider> blocProviders,
}) {
  const defaultTransition = Settings.defaultTransitionAnimation;
  const defaultDuration = Duration(
    milliseconds: Settings.defaultTransitionDuration,
  );

  return (RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) {
          if (blocProviders is List && blocProviders.isNotEmpty) {
            return MultiBlocProvider(
              providers: blocProviders,
              child: widget,
            );
          }

          return widget;
        },
        transitionDuration: duration ?? defaultDuration,
        transitionsBuilder: transition ?? defaultTransition,
      );
}
