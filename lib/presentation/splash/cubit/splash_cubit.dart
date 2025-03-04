import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(DisplayLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(DisplayLoaded());
  }
}
