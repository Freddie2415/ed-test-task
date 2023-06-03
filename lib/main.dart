import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application.dart';
import 'presentation/manager/users/users_cubit.dart';

Future<void> main() async {
  runApp(
    MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => UsersCubit()),
      ],
      child: const Application(),
    ),
  );
}
