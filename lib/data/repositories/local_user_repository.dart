import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/models/comment_model.dart';
import 'package:eds_test/data/models/post_model.dart';
import 'package:eds_test/data/models/user_model.dart';
import 'package:eds_test/data/repositories/user_repository.dart';
import 'package:hive/hive.dart';

class LocalUserRepository implements UserRepository {
  final Box<UserModel> userBox;
  final Box<PostModel> postBox;

  const LocalUserRepository(this.userBox, this.postBox);

  @override
  Future<List<UserModel>> getAllUsers() async {
    return userBox.values.toList();
  }

  @override
  Future<List<AlbumModelWithPhotos>> getAlbumsByUserIdWithPhotos(
    int userId,
  ) async {
    final user = userBox.values.firstWhere((u) => u.id == userId);
    final albums = user.albums?.toList();

    return albums ?? [];
  }

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    final user = userBox.values.firstWhere((u) => u.id == userId);
    final posts = user.posts?.toList();

    return posts ?? [];
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final post = postBox.values.firstWhere((p) => p.id == postId);
    final comments = post.comments?.toList();

    return comments ?? [];
  }

  @override
  Future<void> sendComment({
    required String name,
    required String email,
    required String body,
  }) {
    throw Exception('Please check internet connection!');
  }
}
