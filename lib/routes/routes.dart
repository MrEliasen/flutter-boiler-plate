import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/routes/route_transitions.dart';
import 'package:flutter_app_boilerplate/views/splash_screen.dart';
import 'package:flutter_app_boilerplate/views/welcome.dart';

const _duration = Duration(milliseconds: 200);

Map<String, Function> routes = <String, Function>{
  SplashScreen.routeName: (RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) {
          return SplashScreen();
        },
        transitionDuration: _duration,
        transitionsBuilder: RouteTransitions.fade,
      ),
  Welcome.routeName: (RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Welcome();
        },
        transitionDuration: _duration,
        transitionsBuilder: RouteTransitions.slideUp,
      ),
};
