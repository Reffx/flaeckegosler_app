import 'package:flutter/material.dart';

class Pictures {
  final String id;
  final String menuTitle;
  final String albumTitle;
  final String bodyText;
  final String dateUnix;
  final String dateFormatted;
  final List<dynamic> pictures;

  Pictures({
    @required this.id,
    @required this.menuTitle,
    @required this.albumTitle,
    @required this.bodyText,
    @required this.dateUnix,
    @required this.dateFormatted,
    @required this.pictures,
  });
}
