import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_bloc.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_states.dart';
import 'package:flutter_app_boilerplate/presentation/routes/route_transitions.dart';
import 'package:flutter_app_boilerplate/presentation/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  static Function routeTransition = namedRouteBuilder(
    SplashScreen(),
    transition: RouteTransitions.fade,
    blocProviders: [
      BlocProvider<SplashScreenBloc>(
        create: (BuildContext context) => SplashScreenBloc(),
      ),
    ],
  );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SplashScreenBloc, SplashScreenState>(
              builder: (context, state) {
            return const Text('Splash Screen');
          }),
        ],
      ),
    );
  }
}
