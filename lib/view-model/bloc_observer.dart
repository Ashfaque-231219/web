import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Custom Bloc observer to observe all the blocs
class CustomBlocObserver extends BlocObserver with ChangeNotifier{
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('Bloc Event==> ${bloc.runtimeType}, $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('Bloc change==> ${bloc.runtimeType}, $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('Bloc transition==> ${bloc.runtimeType}, $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('Bloc Error==> ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}
