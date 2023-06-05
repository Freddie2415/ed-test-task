import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository userRepository;

  UsersCubit(this.userRepository) : super(UsersInitial()) {
    load();
  }

  Future<void> load() async {
    emit(UsersLoading());

    try {
      final users = await userRepository.getAllUsers();
      emit(UsersSuccess(list: users));
    } catch (e) {
      emit(UsersFailure(e.toString()));
    }
  }
}
