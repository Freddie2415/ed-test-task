import 'package:eds_test/presentation/manager/cache/cache_cubit.dart';
import 'package:eds_test/presentation/manager/connectivity/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/theme/app_colors.dart';
import '../../presentation/theme/app_text_styles.dart';
import '../manager/users/users_cubit.dart';
import '../shared_widgets/failure_widget.dart';
import '../shared_widgets/loader.dart';
import 'user_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        centerTitle: true,
        actions: [
          BlocConsumer<CacheCubit, CacheState>(
            listener: (context, state) {
              if (state is CacheFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is CacheReady) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cached successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CacheInitial) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<CacheCubit>(context).cache();
                  },
                  icon: const Icon(Icons.download),
                );
              }

              if (state is CacheLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }

              if (state is CacheReady) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<CacheCubit>(context).cache();
                  },
                  icon: const Icon(Icons.download_done),
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersFailure) {
            return FailureWidget(message: state.error);
          }

          if (state is UsersSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<UsersCubit>(context).load();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.list.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  final user = state.list[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserPage(
                            userModel: user,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: AppColors.gray,
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        horizontalTitleGap: 8,
                        title: Text(
                          user.username,
                          style: AppTextStyles.title,
                        ),
                        subtitle: Text(
                          user.name,
                          style: AppTextStyles.subtitle,
                        ),
                        leading: const Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const Loader();
        },
      ),
      bottomSheet: BlocBuilder<ConnectivityCubit, bool>(
        builder: (context, hasConnection) {
          if (hasConnection) {
            return const SizedBox();
          }

          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.red),
            child: const Text(
              'Please check internet connection!',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
