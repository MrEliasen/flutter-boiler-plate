import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/hive/hive_db.dart';
import 'package:flutter_app_boilerplate/presentation/routes/route_transitions.dart';
import 'package:flutter_app_boilerplate/presentation/routes/routes.dart';
import 'package:flutter_app_boilerplate/presentation/welcome/welcome.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';
  static Function routeTransition() => namedRouteBuilder(
        SplashScreen(),
        transition: RouteTransitions.fade,
      );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setup());
  }

  Future setup() async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    await loadSession();

    Navigator.of(context).pushReplacementNamed(Welcome.routeName);
  }

  Future loadSession() async {
    // placeholder
    await HiveDB().session.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Splash Screen'),
        ],
      ),
    );
  }
}
