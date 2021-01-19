import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

/// INITIAL/PROGRESS
class SessionLoadInProgressEvent extends SplashScreenEvent {}

class SessionLoadSuccessEvent extends SplashScreenEvent {
  final User session;

  const SessionLoadSuccessEvent({
    @required this.session,
  }) : assert(session != null);

  @override
  List<Object> get props => [session];

  @override
  String toString() =>
      'SessionLoadSuccessEvent { session: ${session.phoneNumber} }';
}
