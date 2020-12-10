import 'package:Flaeckegosler/models/news.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SingleImage extends StatelessWidget {
  final News singleNews;

  SingleImage(this.singleNews);

  @override
  Widget build(BuildContext context) {
    return /* WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: */
        Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        imageProvider: NetworkImage(singleNews.imageURL),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: true,
      ),
      //    ),r
    );
  }
}
