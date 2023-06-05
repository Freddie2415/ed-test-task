import 'package:bloc/bloc.dart';
import 'package:eds_test/data/models/album_model.dart';

import '../../../data/models/post_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> load(UserModel user) async {
    emit(UserLoading());

    try {
      final posts = await userRepository.getPostsByUserId(user.id);
      final albums = await userRepository.getAlbumsByUserIdWithPhotos(user.id);

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
