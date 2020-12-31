import 'package:flutter/cupertino.dart';

class Welcome extends StatefulWidget {
  static const routeName = 'welcome';

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return const Text('Welcome');
  }
}
