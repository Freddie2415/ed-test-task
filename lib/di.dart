import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eds_test/presentation/manager/comments/comments_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import 'data/models/album_model.dart';
import 'data/models/comment_model.dart';
import 'data/models/photo_model.dart';
import 'data/models/post_model.dart';
import 'data/models/user_model.dart';
import 'data/repositories/local_user_repository.dart';
import 'data/repositories/remote_user_repository.dart';
import 'data/services/network_service.dart';
import 'data/services/user_service.dart';
import 'presentation/manager/cache/cache_cubit.dart';
import 'presentation/manager/connectivity/connectivity_cubit.dart';
import 'presentation/manager/user/user_cubit.dart';
import 'presentation/manager/users/users_cubit.dart';

Future<void> setup() async {
  /// initialize cache db
  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(GeoAdapter())
    ..registerAdapter(CompanyAdapter())
    ..registerAdapter(PostModelAdapter())
    ..registerAdapter(PhotoModelAdapter())
    ..registerAdapter(CommentModelAdapter())
    ..registerAdapter(AlbumModelAdapter())
    ..registerAdapter(AlbumModelWithPhotosAdapter());

  final userBox = await Hive.openBox<UserModel>('user_model');
  final postBox = await Hive.openBox<PostModel>('post_model');
  final commentBox = await Hive.openBox<CommentModel>('comment_model');
  final albumBox =
      await Hive.openBox<AlbumModelWithPhotos>('album_model_with_photos');

  /// initialize services and repositories
  final NetworkService httpNetworkService = HttpNetworkService(backendURl);
  final remoteUserRepository = RemoteUserRepository(httpNetworkService);
  final localUserRepository = LocalUserRepository(userBox, postBox);
  final userService = UserService(
    remote: remoteUserRepository,
    local: localUserRepository,
  );

  /// initialize cubits
  final cacheCubit = CacheCubit(
    remoteUserRepository,
    userBox,
    postBox,
    albumBox,
    commentBox,
  );
  final usersCubit = UsersCubit(userService);
  final userCubit = UserCubit(userService);
  final commentsCubit = CommentsCubit(userService);
  final connectivityCubit = ConnectivityCubit(Connectivity());


  GetIt.I.registerSingleton<UsersCubit>(usersCubit);
  GetIt.I.registerSingleton<UserCubit>(userCubit);
  GetIt.I.registerSingleton<CommentsCubit>(commentsCubit);
  GetIt.I.registerSingleton<ConnectivityCubit>(connectivityCubit);
  GetIt.I.registerSingleton<CacheCubit>(cacheCubit);
}
