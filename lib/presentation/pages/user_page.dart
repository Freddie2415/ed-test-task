import 'package:eds_test/presentation/manager/user/user_cubit.dart';
import 'package:eds_test/presentation/shared_widgets/failure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../presentation/pages/album_detail_page.dart';
import '../../presentation/shared_widgets/album_card.dart';
import '../../presentation/shared_widgets/loader.dart';
import '../../presentation/shared_widgets/post_card.dart';
import '../../presentation/theme/app_text_styles.dart';
import 'all_albums_page.dart';
import 'all_posts_page.dart';
import 'post_detail_page.dart';

class UserPage extends StatelessWidget {
  final UserModel userModel;

  const UserPage({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.username),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        bloc: UserCubit(userModel),
        builder: (context, state) {
          if (state is UserFailure) {
            return FailureWidget(message: state.message);
          }

          if (state is UserSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${userModel.name}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email: ${userModel.email}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Phone: ${userModel.phone}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Website: ${userModel.website}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Working Company',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Name: ${userModel.company.name}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'BS: ${userModel.company.bs}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Catch phase: '${userModel.company.catchPhrase}'",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Address',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'City: ${userModel.address.city}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Street: ${userModel.address.street}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'User Posts',
                          style: AppTextStyles.bodyTextStyle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllPostsPage(
                                user: userModel,
                                posts: state.posts,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailPage(
                                post: post,
                              ),
                            ),
                          );
                        },
                        child: PostCard(
                          post: post,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'User Albums',
                          style: AppTextStyles.bodyTextStyle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllAlbumsPage(
                                user: userModel,
                                albums: state.albums,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      final album = state.albums[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumDetailPage(
                                album: album,
                              ),
                            ),
                          );
                        },
                        child: AlbumCard(
                          album: album,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Loader();
        },
      ),
    );
  }
}
