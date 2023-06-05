import 'user_repository.dart';
import '../models/album_model.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/network_service.dart';

class RemoteUserRepository implements UserRepository {
  final NetworkService networkService;

  const RemoteUserRepository(this.networkService);

  @override
  Future<List<UserModel>> getAllUsers() async {
    final dynamic jsonResponse = await networkService.get(path: '/users');
    final jsonList = jsonResponse as List<dynamic>;

    final users = jsonList.map((e) {
      return UserModel.fromMap(e as Map<String, dynamic>);
    }).toList();

    return users;
  }

  @override
  Future<List<AlbumModelWithPhotos>> getAlbumsByUserIdWithPhotos(
    int userId,
  ) async {
    final dynamic jsonResponse =
        await networkService.get(path: '/user/$userId/albums?_embed=photos');
    final jsonList = jsonResponse as List<dynamic>;

    return jsonList.map((e) {
      return AlbumModelWithPhotos.fromMap(e as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    final dynamic jsonResponse =
        await networkService.get(path: '/user/$userId/posts');
    final jsonList = jsonResponse as List<dynamic>;

    return jsonList.map((e) {
      return PostModel.fromMap(e as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final dynamic jsonResponse =
        await networkService.get(path: '/posts/$postId/comments/');
    final jsonList = jsonResponse as List<dynamic>;

    return jsonList.map((e) {
      return CommentModel.fromMap(e as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<void> sendComment({
    required String name,
    required String email,
    required String body,
  }) async {
    await networkService.post(
      path: '/comments/',
      data: <String, String>{
        'name': name,
        'email': email,
        'body': body,
      },
    );
  }
}
