import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/models/comment_model.dart';
import 'package:eds_test/data/models/post_model.dart';
import 'package:eds_test/data/repositories/remote_user_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_model.dart';

part 'cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  final RemoteUserRepository remoteUserRepository;
  final Box<UserModel> userBox;
  final Box<PostModel> postBox;
  final Box<AlbumModel> albumBox;
  final Box<CommentModel> commentBox;

  CacheCubit(
    this.remoteUserRepository,
    this.userBox,
    this.postBox,
    this.albumBox,
    this.commentBox,
  ) : super(CacheInitial()) {
    init();
  }

  Future<void> cache() async {
    try {
      emit(CacheLoading());
      final users = await remoteUserRepository.getAllUsers();

      await userBox.clear();
      await postBox.clear();
      await albumBox.clear();
      await commentBox.clear();

      await userBox.addAll(users);

      for (final user in users) {
        final posts = await remoteUserRepository.getPostsByUserId(user.id);
        final albums =
            await remoteUserRepository.getAlbumsByUserIdWithPhotos(user.id);

        await postBox.addAll(posts);
        await albumBox.addAll(albums);

        user
          ..posts = HiveList(postBox)
          ..albums = HiveList(albumBox);

        user.posts?.addAll(posts);

        for (final post in user.posts?.toList() ?? <PostModel>[]) {
          final comments =
              await remoteUserRepository.getCommentsByPostId(post.id);

          await commentBox.addAll(comments);

          post.comments = HiveList(commentBox);
          post.comments?.addAll(comments);
          await post.save();
        }

        user.albums?.addAll(albums);

        await user.save();
      }
      emit(CacheReady());
    } on SocketException {
      await userBox.clear();
      await postBox.clear();
      await albumBox.clear();
      await commentBox.clear();

      emit(CacheFailure("Please check your internet connection"));
      emit(CacheInitial());
    } catch (e) {
      await userBox.clear();
      await postBox.clear();
      await albumBox.clear();
      await commentBox.clear();

      emit(CacheFailure(e.toString()));
      emit(CacheInitial());
    }
  }

  Future<void> init() async {
    final isCached = userBox.values.isNotEmpty &&
        postBox.values.isNotEmpty &&
        albumBox.values.isNotEmpty &&
        commentBox.values.isNotEmpty;
    if (isCached) {
      emit(CacheReady());
    } else {
      emit(CacheInitial());
    }
  }
}
