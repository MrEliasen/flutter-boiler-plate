import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';

abstract class SplashScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSessionEvent extends SplashScreenEvent {
  final User session;

  LoadSessionEvent({@required this.session}) : assert(session != null);
}
