import 'package:equatable/equatable.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

/// INITIAL/PROGRESS
class SessionLoadInProgressState extends SplashScreenState {}

/// SUCCESS
class SessionLoadSuccessState extends SplashScreenState {
  final User session;

  const SessionLoadSuccessState([this.session]);

  @override
  List<Object> get props => [session];

  @override
  String toString() =>
      'SessionLoadSuccessState { session: ${session.toMap().toString()} }';
}

/// FAILURE
class SessionLoadFailureState extends SplashScreenState {
  final dynamic error;
  final StackTrace stackTrace;

  const SessionLoadFailureState([this.error, this.stackTrace]);
}
