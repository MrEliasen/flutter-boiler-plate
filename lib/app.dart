import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/core/app_theme.dart';
import 'package:flutter_app_boilerplate/views/splash_screen.dart';

import 'routes/routes.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  const App(this.navKey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ord',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.swatch,
      ),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        // return the route if found
        if (routes.containsKey(settings.name)) {
          return routes[settings.name](settings) as Route<dynamic>;
        }

        // otherwise return "404" error page
        return routes['/unknown-route']() as Route<dynamic>;
      },
      navigatorKey: navKey,
    );
  }
}
