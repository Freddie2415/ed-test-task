part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String message;

  UserFailure(this.message);
}

class UserSuccess extends UserState {
  final UserModel userModel;
  final List<PostModel> posts;
  final List<AlbumModelWithPhotos> albums;

  UserSuccess({
    required this.userModel,
    required this.posts,
    required this.albums,
  });
}
