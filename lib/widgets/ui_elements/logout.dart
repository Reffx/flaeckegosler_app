import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';


class LogoutWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            model.logout();
          },
        );
      },
    );
  }
}