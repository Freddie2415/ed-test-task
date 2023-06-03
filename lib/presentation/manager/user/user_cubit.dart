import 'package:bloc/bloc.dart';
import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/services/api_service.dart';

import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserModel user;

  UserCubit(this.user) : super(UserInitial()) {
    load();
  }

  Future<void> load() async {
    emit(UserLoading());

    try {
      final posts = await ApiService.getPostsByUserId(user.id);
      final albums = await ApiService.getAlbumsByUserIdWithPhotos(user.id);

      emit(
        UserSuccess(
          userModel: user,
          posts: posts,
          albums: albums,
        ),
      );
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
