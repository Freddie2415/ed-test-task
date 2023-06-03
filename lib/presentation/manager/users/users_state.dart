part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersFailure extends UsersState {
  final String error;

  UsersFailure(this.error);
}

class UsersSuccess extends UsersState {
  final List<UserModel> list;

  UsersSuccess({required this.list});
}
