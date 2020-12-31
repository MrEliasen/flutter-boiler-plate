import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/core/app_safe_area.dart';
import 'package:flutter_app_boilerplate/hive/hive_controller.dart';
import 'package:flutter_app_boilerplate/views/welcome.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';

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

    /// instantiate the AppSafeArea helper
    AppSafeArea(offset: MediaQuery.of(context).padding);

    await loadSession();

    Navigator.of(context).pushReplacementNamed(Welcome.routeName);
  }

  Future loadSession() async {
    // placeholder
    await HiveController().session.get();
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
