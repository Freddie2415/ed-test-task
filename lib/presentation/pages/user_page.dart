import 'package:flutter/material.dart';

import '../../data/models/album_model.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/api_service.dart';
import '../../presentation/pages/album_detail_page.dart';
import '../../presentation/shared_widgets/album_card.dart';
import '../../presentation/shared_widgets/loader.dart';
import '../../presentation/shared_widgets/post_card.dart';
import '../../presentation/theme/app_text_styles.dart';
import 'all_albums_page.dart';
import 'all_posts_page.dart';
import 'post_detail_page.dart';

class UserPage extends StatefulWidget {
  final UserModel userModel;

  const UserPage({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLoading = true;
  List<PostModel> posts = List.empty();
  List<AlbumModelWithPhotos> albums = List.empty();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      posts = await ApiService.getPostsByUserId(widget.userModel.id);
      albums =
          await ApiService.getAlbumsByUserIdWithPhotos(widget.userModel.id);
      setState(() {
        _isLoading = false;
        posts = posts;
        albums = albums;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userModel.username),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Loader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${widget.userModel.name}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email: ${widget.userModel.email}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Phone: ${widget.userModel.phone}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Website: ${widget.userModel.website}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Working Company',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Name: ${widget.userModel.company.name}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'BS: ${widget.userModel.company.bs}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Catch phase: '${widget.userModel.company.catchPhrase}'",
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Address',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'City: ${widget.userModel.address.city}',
                    style: AppTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Street: ${widget.userModel.address.street}',
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
                                user: widget.userModel,
                                posts: posts,
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
                      final post = posts[index];
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
                                user: widget.userModel,
                                albums: albums,
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
                      final album = albums[index];
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
            ),
    );
  }
}
