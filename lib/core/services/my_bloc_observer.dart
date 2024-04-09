import 'package:finance/core/utils/shared_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // SessionCubit().resetAppSessionTimer();
    printLog('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // SessionCubit().resetAppSessionTimer();
    printLog('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // SessionCubit().resetAppSessionTimer();
    printLog('onError -- ${bloc.runtimeType}, $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // SessionCubit().resetAppSessionTimer();
    printLog('onClose -- ${bloc.runtimeType}');
  }
}
