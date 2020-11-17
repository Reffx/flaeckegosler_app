import 'package:Flaeckegosler/models/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider with ChangeNotifier {
  List<News> _news = [];
  String _selNewsId;

  List<News> get allNews {
    return List.from(_news);
  }

  int get selectedNewsIndex {
    return _news.indexWhere((News news) {
      return news.id == _selNewsId;
    });
  }

  String get selectedNewsId {
    return _selNewsId;
  }

  News get selectedNews {
    if (selectedNewsId == null) {
      return null;
    }
    return _news.firstWhere((News news) {
      return news.id == _selNewsId;
    });
  }

  Future<bool> fetchProducts() {
    return http
        .get('https://flaeckegosler.ch/app/news-to-json/')
        .timeout(Duration(seconds: 6))
        .then<Null>((http.Response response) {
      final List<News> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        return;
      }
      productListData.forEach((String productId, dynamic newsData) {
        final News news = News(
            id: productId.toString(),
            newsTitle: newsData['newsTitle'],
            imageURL: newsData['imageURL'],
            cropImageURL: newsData['cropImageURL'],
            timeCreatedUnix: newsData['timeCreatedUnix'],
            timeCreatedFormatted: newsData['timeCreatedFormatted'],
            newsCreatedBy: newsData['newsCreatedBy'],
            newsIntroText: newsData['newsIntroText'],
            newsMainText: newsData['newsMainText'],
            imageDescription: newsData['imageDescription'],
            newsTags: newsData['newsTags'],
            galleryLink: newsData['galleryLink']);
        fetchedProductList.add(news);
      });
      _news = fetchedProductList;
      _selNewsId = null;
    }).catchError((error) {
      throw (error);
    });
  }

  void selectNews(String newsId) {
    _selNewsId = newsId;
    notifyListeners();
  }
}
