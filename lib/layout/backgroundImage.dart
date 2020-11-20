import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final _isNewLayout;
  BackgroundImage(this._isNewLayout);

  @override
  Widget build(BuildContext context) {
    if (_isNewLayout) {
      return Image.asset(
        'assets/layout_2020/MUSTER_REPETIEREND_apptitle.png',
        fit: BoxFit.fitWidth,
      );
    } else {
      return Image.asset(
        'assets/appBarJubi.png',
        fit: BoxFit.fitHeight,
      );
    }
  }
}
