import 'package:flutter/material.dart';

class RouteTransitions {
  static SlideTransition _createSlideAnimation(
      Animation<double> animation, Widget child, Offset begin, Offset end) {
    final tween = Tween(
      begin: begin,
      end: end,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.ease,
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }

  static SlideTransition slideUp(
      _, Animation<double> animation, __, Widget child) {
    const Offset start = Offset(0.0, 1.0);
    const Offset end = Offset.zero;
    return RouteTransitions._createSlideAnimation(animation, child, start, end);
  }

  static SlideTransition slideDown(
      _, Animation<double> animation, __, Widget child) {
    const Offset start = Offset(0.0, -1.0);
    const Offset end = Offset.zero;
    return RouteTransitions._createSlideAnimation(animation, child, start, end);
  }

  static SlideTransition slideToLeft(
      _, Animation<double> animation, __, Widget child) {
    const Offset start = Offset(1.0, 0.0);
    const Offset end = Offset.zero;
    return RouteTransitions._createSlideAnimation(animation, child, start, end);
  }

  static SlideTransition slideToRight(
      _, Animation<double> animation, __, Widget child) {
    const Offset start = Offset(-1.0, 0.0);
    const Offset end = Offset.zero;
    return RouteTransitions._createSlideAnimation(animation, child, start, end);
  }

  static FadeTransition fade(_, Animation<double> animation, __, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static SlideTransition pushUp(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Tween<Offset> parentAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    );

    final Tween<Offset> childAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -1.0),
    );

    return SlideTransition(
      position: parentAnimation.animate(animation),
      child: SlideTransition(
        position: childAnimation.animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}
