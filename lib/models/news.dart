import 'package:flutter/material.dart';

class News {
  final String id;
  final String newsTitle;
  final String imageURL;
  final String cropImageURL;
  final int timeCreatedUnix;
  final String timeCreatedFormatted;
  final String newsCreatedBy;
  final String newsIntroText;
  final String newsMainText;
  final String imageDescription;

  News(
      {@required this.id,
      @required this.newsTitle,
      @required this.imageURL,
      @required this.cropImageURL,
      @required this.timeCreatedUnix,
      @required this.timeCreatedFormatted,
      this.newsCreatedBy,
      @required this.newsIntroText,
      @required this.newsMainText,
      this.imageDescription,
      });
}
