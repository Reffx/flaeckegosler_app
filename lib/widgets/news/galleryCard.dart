import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/redakteure/raphikoch.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
