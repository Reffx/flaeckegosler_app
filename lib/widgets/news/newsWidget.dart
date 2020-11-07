import 'package:Flaeckegosler/models/news.dart';
import 'package:flutter/material.dart';

import 'news_card.dart';

class NewsWidget extends StatelessWidget {
  final List<News> news;
  NewsWidget({@required this.news});

  @override
  Widget build(BuildContext context) {
    return _buildNewsList(news);
  }
}

Widget _buildNewsList(List<News> news) {
  Widget newsCards = Center(
    child: Text('No news found, please add some'),
  );
  if (news.length > 0) {
    newsCards = ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          NewsCard(news, news[index], index),
      itemCount: 12, //news.length
    );
  } else {
    newsCards = Container();
  }
  return newsCards;
}
