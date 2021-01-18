import 'package:bloc/bloc.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_events.dart';
import 'package:flutter_app_boilerplate/application/splash_screen/splash_screen_states.dart';
import 'package:flutter_app_boilerplate/infrastructure/sources/local/db/hive/hive_db.dart';
import 'package:flutter_app_boilerplate/models/auth/user.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc({SplashScreenState initialState})
      : super(initialState ?? SplashScreenInitialState());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    switch (event.runtimeType) {
      case LoadSessionEvent:
        try {
          yield SessionLoadingState();
          final User user = await _loadSession();
          yield SessionLoadedState(user);
        } catch (error, stackTrace) {
          yield SessionLoadingErrorState(error, stackTrace);
        }
        break;

      default:
        throw UnsupportedError('Event not supported');
        break;
    }
  }

  Future<User> _loadSession() async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    return HiveDB().session.get();
  }
}
