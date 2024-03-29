import 'package:Flaeckegosler/models/pictures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PicturesProvider with ChangeNotifier {
  List<Pictures> _pictures = [];

  List<Pictures> get allPictures {
    return List.from(_pictures);
  }

  Future<bool> fetchPicturesList() {
    return http
        .get('https://flaeckegosler.ch/app/pics-to-json/')
        .then<Null>((http.Response response) {
      final List<Pictures> fetchedPicturesList = [];
      final Map<String, dynamic> picturesListData = json.decode(response.body);
      if (picturesListData == null) {
        return;
      }
      picturesListData.forEach((
        String picturesId,
        dynamic picturesData,
      ) {
        //Resolve map to List
        List<SpecificImage> temp = [];
        picturesData['pictures'].forEach((k, v) =>
            (temp.add(SpecificImage(pictureName: k, pictureLink: v))));
        final Pictures pictures = Pictures(
            id: picturesId.toString(),
            menuTitle: picturesData['menuTitle'],
            albumTitle: picturesData['albumTitle'],
            bodyText: picturesData['bodyText'],
            dateUnix: picturesData['dateUnix'],
            dateFormatted: picturesData['dateFormatted'],
            specificImage: temp);
        fetchedPicturesList.add(pictures);
      });
      _pictures = fetchedPicturesList;
    }).catchError((error) {
      throw (error);
    });
  }
}
