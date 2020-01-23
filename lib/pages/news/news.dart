import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/news/news.dart';
import '../../scoped-models/main.dart';

class NewsPage extends StatefulWidget {
  final MainModel model;
  NewsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  @override
  initState() {
    //widget.model.fetchFasnacht();
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildNewsList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Keine Artikel gefunden, überprüfe deine Internetverbindung!'));
      if (model.allNews.length > 0 && !model.isLoading) {
        content = NewsWidget();
      } else if (model.isLoading) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }
      return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //  leading: Image.asset('assets/goslergrend.png', fit: BoxFit.fitHeight),
          title: Image.asset('assets/goslergrend.png', fit: BoxFit.fitHeight),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pushNamed(context, '/info');
              },
            ),
          ],
        ),
        body: _buildNewsList());
  }
}
