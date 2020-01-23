import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 34.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
      ),
    );
  }
}
