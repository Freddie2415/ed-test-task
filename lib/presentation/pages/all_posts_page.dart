import 'package:flutter/material.dart';

import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';
import '../shared_widgets/post_card.dart';
import 'post_detail_page.dart';

class AllPostsPage extends StatefulWidget {
  final UserModel user;
  final List<PostModel> posts;

  const AllPostsPage({
    required this.user,
    required this.posts,
    Key? key,
  }) : super(key: key);

  @override
  State<AllPostsPage> createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.posts.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final post = widget.posts[index];
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
    );
  }
}
