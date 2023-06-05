import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCubit extends Cubit<bool> {
  late StreamSubscription<ConnectivityResult> subscription;

  ConnectivityCubit(Connectivity connectivity) : super(false) {
    subscription = connectivity.onConnectivityChanged.listen((result) {
      emit(ConnectivityResult.none != result);
    });
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
