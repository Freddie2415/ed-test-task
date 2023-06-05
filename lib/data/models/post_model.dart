import 'package:hive/hive.dart';

import 'comment_model.dart';

part 'post_model.g.dart';

@HiveType(typeId: 5)
class PostModel extends HiveObject {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String body;

  @HiveField(4)
  HiveList<CommentModel>? comments;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
        userId: map['userId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
      );
}
