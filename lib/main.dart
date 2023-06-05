import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eds_test/data/models/album_model.dart';
import 'package:eds_test/data/models/comment_model.dart';
import 'package:eds_test/data/models/photo_model.dart';
import 'package:eds_test/data/models/post_model.dart';
import 'package:eds_test/data/models/user_model.dart';
import 'package:eds_test/data/repositories/local_user_repository.dart';
import 'package:eds_test/data/repositories/remote_user_repository.dart';
import 'package:eds_test/data/services/network_service.dart';
import 'package:eds_test/data/services/user_service.dart';
import 'package:eds_test/presentation/manager/cache/cache_cubit.dart';
import 'package:eds_test/presentation/manager/comments/comments_cubit.dart';
import 'package:eds_test/presentation/manager/connectivity/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'application.dart';
import 'presentation/manager/user/user_cubit.dart';
import 'presentation/manager/users/users_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  const baseUrl = 'https://jsonplaceholder.typicode.com';

  final NetworkService httpNetworkService = HttpNetworkService(baseUrl);

  final remoteUserRepository = RemoteUserRepository(httpNetworkService);
  final localUserRepository = LocalUserRepository(userBox, postBox);

  final userService = UserService(
    remote: remoteUserRepository,
    local: localUserRepository,
  );

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

  runApp(
    MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => cacheCubit),
        BlocProvider(create: (_) => usersCubit),
        BlocProvider(create: (_) => userCubit),
        BlocProvider(create: (_) => commentsCubit),
        BlocProvider(create: (_) => connectivityCubit),
      ],
      child: const Application(),
    ),
  );
}
