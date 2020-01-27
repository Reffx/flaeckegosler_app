import 'package:flutter/material.dart';

class MadeWithLoveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        'Made with ♥ in Rothenburg',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald',
          color: Colors.black,
        ),
      ),
    );
  }

}