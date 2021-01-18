import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/presentation/routes/routes.dart';

class Welcome extends StatefulWidget {
  /// required for named routes.
  static const routeName = 'welcome';
  static Function routeTransition() => namedRouteBuilder(widget: Welcome());

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return const Text('Welcome');
  }
}
