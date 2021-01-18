import 'package:equatable/equatable.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashScreenInitialState extends SplashScreenState {}

class SessionLoadingState extends SplashScreenState {}

class SessionLoadedState extends SplashScreenState {
  final User session;

  SessionLoadedState(this.session);
}

class SessionNotLoadedState extends SplashScreenState {}

class SessionLoadingErrorState extends SplashScreenState {
  final dynamic error;
  final StackTrace stackTrace;

  SessionLoadingErrorState(this.error, this.stackTrace);
}
