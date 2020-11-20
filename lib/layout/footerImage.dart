import 'package:flutter/material.dart';

class FooterImage extends StatelessWidget {
  final _isNewLayout;

  FooterImage(this._isNewLayout);

  @override
  Widget build(BuildContext context) {
    if (_isNewLayout) {
      return Image.asset(
        'assets/layout_2020/news_bottom.png',
        fit: BoxFit.fitWidth,
      );
    } else
      return Image.asset(
        'assets/zapfen.png',
        fit: BoxFit.fitWidth,
      );
  }
}
