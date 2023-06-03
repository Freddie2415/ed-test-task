import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../data/services/api_service.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial()) {
    load();
  }

  Future<void> load() async {
    emit(UsersLoading());

    try {
      final list = await ApiService.getAllUsers();

      emit(UsersSuccess(list: list));
    } on SocketException {
      emit(UsersFailure('Network error! Please check internet connection!'));
    } catch (e) {
      emit(UsersFailure(e.toString()));
    }
  }
}
