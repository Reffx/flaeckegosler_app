import './../../models/news.dart';
import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  final News news;
  final String galleryLink;
  GalleryCard(this.news, this.galleryLink);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed<bool>(
        context,
        '/specific_image/' + news.id,
        arguments: galleryLink,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              galleryLink,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
