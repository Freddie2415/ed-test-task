import 'package:eds_test/data/models/photo_model.dart';
import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: 8)
class AlbumModel extends HiveObject{
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumModel.fromMap(Map<String, dynamic> map) => AlbumModel(
        userId: map['userId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
      );
}

@HiveType(typeId: 9)
class AlbumModelWithPhotos extends AlbumModel {
  @HiveField(3)
  final List<PhotoModel> photos;

  AlbumModelWithPhotos({
    required int userId,
    required int id,
    required String title,
    required this.photos,
  }) : super(
          userId: userId,
          id: id,
          title: title,
        );

  factory AlbumModelWithPhotos.fromMap(Map<String, dynamic> map) =>
      AlbumModelWithPhotos(
        userId: map['userId'] as int,
        id: map['id'] as int,
        title: map['title'] as String,
        photos: List<PhotoModel>.from(
          List<Map<String, dynamic>>.from(map['photos'] as List)
              .map<PhotoModel>(PhotoModel.fromMap),
        ),
      );
}
