import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SimplePhotoViewPage extends StatelessWidget {
  final String galleryLink;

  SimplePhotoViewPage(this.galleryLink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(
          galleryLink,
        ),
        // Contained = the smallest possible size to fit one dimension of the screen
        minScale: PhotoViewComputedScale.contained * 0.8,
        // Covered = the smallest possible size to fit the whole screen
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: true,
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
