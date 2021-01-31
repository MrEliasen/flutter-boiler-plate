import 'package:flutter/material.dart';

class GlobalNavigator {
  /// the global navigation key
  GlobalKey<NavigatorState> _navKey;

  /// the singleton instances
  static GlobalNavigator _instance;

  factory GlobalNavigator({GlobalKey<NavigatorState> navKey}) {
    if (_instance != null) {
      return _instance;
    }

    return _instance = GlobalNavigator._(navKey);
  }

  GlobalNavigator._(this._navKey);

  /// Push the given route onto the navigator.
  Future push(Route route) {
    return _navKey.currentState.push(route);
  }

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  Future pushReplacement(Route route) {
    return _navKey.currentState.pushReplacement(route);
  }

  /// Push a named route onto the navigator.
  Future pushNamed(String routeName, {Object arguments}) {
    return _navKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  Future pushReplacementNamed(String routeName, {Object arguments}) {
    return _navKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  Future pushNamedAndRemoveUntil(
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) {
    return _navKey.currentState.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  Future pushAndRemoveUntil(Route route, RoutePredicate predicate) {
    return _navKey.currentState.pushAndRemoveUntil(route, predicate);
  }

  /// Pop the top-most route off the navigator.
  void pop(Route route) {
    return _navKey.currentState.pop();
  }

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  Future popAndPushNamed(String routeName, {Object arguments}) {
    return _navKey.currentState.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Calls [pop] repeatedly until the predicate returns true.
  void popUntil(RoutePredicate predicate) {
    return _navKey.currentState.popUntil(predicate);
  }
}
