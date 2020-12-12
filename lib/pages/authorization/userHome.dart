import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pushNamed(context, '/');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          Text("Test"),
        ]),
      ),
    );
  }
}
