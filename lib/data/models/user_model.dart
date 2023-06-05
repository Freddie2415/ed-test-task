import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/models/post_model.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final Address address;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final String website;
  @HiveField(7)
  final Company company;

  @HiveField(8)
  HiveList<PostModel>? posts;
  @HiveField(9)
  HiveList<AlbumModelWithPhotos>? albums;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as int,
        name: map['name'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        address: Address.fromMap(map['address'] as Map<String, dynamic>),
        phone: map['phone'] as String,
        website: map['website'] as String,
        company: Company.fromMap(map['company'] as Map<String, dynamic>),
      );
}

@HiveType(typeId: 2)
class Address extends HiveObject {
  @HiveField(0)
  final String street;
  @HiveField(1)
  final String suite;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final String zipcode;
  @HiveField(4)
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        street: map['street'] as String,
        suite: map['suite'] as String,
        city: map['city'] as String,
        zipcode: map['zipcode'] as String,
        geo: Geo.fromMap(map['geo'] as Map<String, dynamic>),
      );
}

@HiveType(typeId: 3)
class Geo extends HiveObject {
  @HiveField(0)
  final String lat;
  @HiveField(1)
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromMap(Map<String, dynamic> map) => Geo(
        lat: map['lat'] as String,
        lng: map['lng'] as String,
      );
}

@HiveType(typeId: 4)
class Company extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String catchPhrase;
  @HiveField(2)
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        name: map['name'] as String,
        catchPhrase: map['catchPhrase'] as String,
        bs: map['bs'] as String,
      );
}
