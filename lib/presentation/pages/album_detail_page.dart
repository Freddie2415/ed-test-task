import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/models/album_model.dart';

class AlbumDetailPage extends StatelessWidget {
  final AlbumModelWithPhotos album;

  const AlbumDetailPage({
    required this.album,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: Center(
        child: CarouselSlider.builder(
          itemCount: album.photos.length,
          itemBuilder: (context, index, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(
                      album.photos[index].url,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(album.photos[index].title)
                ],
              ),
            );
          },
          options: CarouselOptions(height: 400),
        ),
      ),
    );
  }
}
