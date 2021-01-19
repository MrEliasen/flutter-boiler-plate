import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_events.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_states.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/db/hive/hive_db.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SessionLoadInProgressState());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    print(event.runtimeType);

    switch (event.runtimeType) {
      case SessionLoadInProgressEvent:
        yield* _mapSessionLoadedState();
        break;

      default:
        print('Event "${event.runtimeType}" not supported');
        break;
    }
  }

  Stream<SplashScreenState> _mapSessionLoadedState() async* {
    try {
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
      final User user = await HiveDB().session.get();

      yield SessionLoadSuccessState(user);
    } catch (error, stackTrace) {
      yield SessionLoadFailureState(error, stackTrace);
    }
  }
}
