import 'package:Flaeckegosler/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MadeWithLoveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Provider.of<AuthProvider>(context, listen: false).logout();
          print("logged out");
        },
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
      ),
    );
  }
}
