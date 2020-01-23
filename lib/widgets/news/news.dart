import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './news_card.dart';
import '../../models/news.dart';
import '../../scoped-models/main.dart';

class NewsWidget extends StatelessWidget {
  Widget _buildNewsList(List<News> news) {
    Widget newsCards = Center(
      child: Text('No news found, please add some'),
    );
    if (news.length > 0) {
      newsCards = ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            NewsCard(news[index], index),
        itemCount: 12, //news.length
      );
    } else {
      newsCards = Container();
    }
    return newsCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildNewsList(model.allNews);
      },
    );
  }
}

