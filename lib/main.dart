import 'package:eds_test/di.dart';
import 'package:eds_test/presentation/manager/cache/cache_cubit.dart';
import 'package:eds_test/presentation/manager/comments/comments_cubit.dart';
import 'package:eds_test/presentation/manager/connectivity/connectivity_cubit.dart';
import 'package:eds_test/presentation/manager/user/user_cubit.dart';
import 'package:eds_test/presentation/manager/users/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(
    MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => GetIt.I.get<CacheCubit>()),
        BlocProvider(create: (_) => GetIt.I.get<UsersCubit>()),
        BlocProvider(create: (_) => GetIt.I.get<UserCubit>()),
        BlocProvider(create: (_) => GetIt.I.get<CommentsCubit>()),
        BlocProvider(create: (_) => GetIt.I.get<ConnectivityCubit>()),
      ],
      child: const Application(),
    ),
  );
}
