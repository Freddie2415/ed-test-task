import 'dart:io';

import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/models/comment_model.dart';
import 'package:eds_test/data/models/post_model.dart';
import 'package:eds_test/data/models/user_model.dart';
import 'package:eds_test/data/repositories/local_user_repository.dart';
import 'package:eds_test/data/repositories/remote_user_repository.dart';
import 'package:eds_test/data/repositories/user_repository.dart';

class UserService extends UserRepository {
  final RemoteUserRepository remote;
  final LocalUserRepository local;

  UserService({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final users = await remote.getAllUsers();
      return users;
    } on SocketException {
      final users = await local.getAllUsers();
      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AlbumModelWithPhotos>> getAlbumsByUserIdWithPhotos(
    int userId,
  ) async {
    try {
      final albums = await remote.getAlbumsByUserIdWithPhotos(userId);

      return albums;
    } on SocketException {
      final albums = await local.getAlbumsByUserIdWithPhotos(userId);
      return albums;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    try {
      final comments = await remote.getCommentsByPostId(postId);
      return comments;
    } on SocketException {
      final comments = await local.getCommentsByPostId(postId);
      return comments;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    try {
      final posts = await remote.getPostsByUserId(userId);
      return posts;
    } on SocketException {
      final posts = await local.getPostsByUserId(userId);
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendComment({
    required String name,
    required String email,
    required String body,
  }) async {
    await remote.sendComment(
      name: name,
      email: email,
      body: body,
    );
  }
}
