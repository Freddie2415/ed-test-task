import 'package:bloc/bloc.dart';
import 'package:eds_test/data/models/comment_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repositories/user_repository.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final UserRepository userRepository;

  CommentsCubit(this.userRepository) : super(CommentsInitial());

  Future<void> load(int postId) async {
    emit(CommentsLoading());

    try {
      final comments = await userRepository.getCommentsByPostId(postId);

      emit(CommentsSuccess(comments));
    } catch (e) {
      emit(CommentsFailure(e.toString()));
    }
  }

  Future<void> submit({
    required String name,
    required String email,
    required String body,
  }) async {
    await userRepository.sendComment(
      name: name,
      email: email,
      body: body,
    );
  }
}
