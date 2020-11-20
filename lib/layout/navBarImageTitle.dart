import 'package:flutter/material.dart';

class NavBarImageTitle extends StatelessWidget {
  final _isNewLayout;

  NavBarImageTitle(this._isNewLayout);

  @override
  Widget build(BuildContext context) {
    if (_isNewLayout) {
      return Image.asset(
        'assets/layout_2020/goslermythos_title.png',
        height: 50,
      );
    } else
      return Image.asset(
        'assets/diadamas.png',
        height: 40,
      );
  }
}
