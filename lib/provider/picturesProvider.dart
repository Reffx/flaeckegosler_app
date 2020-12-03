import 'package:Flaeckegosler/models/pictures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PicturesProvider with ChangeNotifier {
  List<Pictures> _pictures = [];

  Future<bool> fetchNewsList() {
    return http
        .get('https://flaeckegosler.ch/app/news-to-json/')
        .then<Null>((http.Response response) {
      final List<Pictures> fetchedPicturesList = [];
      final Map<String, dynamic> picturesListData = json.decode(response.body);
      if (picturesListData == null) {
        return;
      }
      picturesListData.forEach((String picturesId, dynamic picturesData) {
        final Pictures pictures = Pictures(
            id: picturesId.toString(),
            menuTitle: picturesData['menuTitle'],
            albumTitle: picturesData['albumTitle'],
            bodyText: picturesData['bodyText'],
            dateUnix: picturesData['dateUnix'],
            dateFormatted: picturesData['dateFormatted'],
            pictures: picturesData['pictures']);
        fetchedPicturesList.add(pictures);
      });
      _pictures = fetchedPicturesList;
    }).catchError((error) {
      throw (error);
    });
  }
}
