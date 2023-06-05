import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 6)
class PhotoModel extends HiveObject{
  @HiveField(0)
  final int albumId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;

  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) => PhotoModel(
        albumId: map['albumId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
        url: '${map['url']}.jpg',
        thumbnailUrl: '${map['thumbnailUrl']}.jpg',
      );
}
