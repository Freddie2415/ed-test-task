import 'package:eds_test/data/models/comment_model.dart';
import 'package:eds_test/data/models/user_model.dart';

import '../models/album_model.dart';
import '../models/post_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();

  Future<List<PostModel>> getPostsByUserId(int userId);

  Future<List<AlbumModelWithPhotos>> getAlbumsByUserIdWithPhotos(int userId);

  Future<List<CommentModel>> getCommentsByPostId(int postId);

  Future<void> sendComment({
    required String name,
    required String email,
    required String body,
  });
}
