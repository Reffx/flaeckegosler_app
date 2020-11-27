import './../../models/news.dart';
import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  final News news;
  GalleryCard(this.news);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed<bool>(
        context,
        '/specific_image/' + news.id,
        arguments: news,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/redakteure/raphikoch.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
