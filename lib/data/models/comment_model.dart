import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 7)
class CommentModel extends HiveObject{
  @HiveField(0)
  final int postId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) => CommentModel(
        postId: map['postId'] as int,
        id: map['id'] as int,
        name: map['name'] as String,
        email: map['email'] as String,
        body: map['body'] as String,
      );
}
