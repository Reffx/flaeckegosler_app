import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/news.dart';
import '../../scoped-models/main.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final int newsIndex;

  NewsCard(this.news, this.newsIndex);

  Widget _buildTitle() {
    return Text(
      news.newsTitle,
      textAlign: TextAlign.start,
      style: TextStyle(
        height: 1.2,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald',
        color: Colors.black,
        background: Paint()..color = Colors.white,
      ),
    );
  }

  Widget _buildAuthor() {
    if (news.newsCreatedBy == null || news.newsCreatedBy == 'Administrator') {
      return SizedBox(
        height: 10,
      );
    } else
      return Text(
        'von ' + news.newsCreatedBy,
        textAlign: TextAlign.start,
        style: TextStyle(
          height: 1.2,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald',
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Colors.black,
            ),
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 8.0,
              color: Colors.black,
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed<bool>(
            context, '/specific_news/' + model.allNews[newsIndex].id),
        child: Container(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildTitle(),
                _buildAuthor(),
              ],
            ),
            height: 250,
            //MediaQuery.of(context).size.heiSght,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: new Border(
                left: BorderSide(color: Colors.white, width: 10.0),
                top: BorderSide(color: Colors.white, width: 10.0),
                right: BorderSide(color: Colors.white, width: 10.0),
                bottom: BorderSide(color: Colors.white, width: 0.0),
              ),
              //borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(news.imageURL), fit: BoxFit.cover),
            ),
          ),
        ),
      );
    });
  }
}
