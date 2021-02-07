import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen.dart';
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
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<SplashScreenBloc>(context);
    bloc.add(SessionLoadInProgressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              if (state is SessionLoadFailureState) {
                return const Text('Failed To load Session');
              }

              if (state is SessionLoadInProgressState) {
                return const Text('Loading session..');
              }

              return const Text('Loaded and ready');
            },
          ),
        ],
      ),
    );
  }
}
