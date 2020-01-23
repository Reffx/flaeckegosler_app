import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import '../../models/fasnacht_date.dart';

import '../../widgets/news/news.dart';
import '../../scoped-models/main.dart';

const my_url = 'https://flaeckegosler.ch/admin';

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print('Could not launch $url');
  }
}

class NewsPageFasnacht extends StatefulWidget {
  final MainModel model;
  NewsPageFasnacht(this.model);
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPageFasnacht> {
  @override
  initState() {
  //  widget.model.fetchFasnacht();
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildNewsList() {
    return Column(children: <Widget>[
      ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(
            child: Text(
                'Keine Artikel gefunden! Überprüfe deine Internetverbindung!'));
        if (model.allNews.length > 0 && !model.isLoading) {
          content = NewsWidget();
        } else if (model.isLoading) {
          content = Column(
            children: <Widget>[
              SizedBox(height: 50),
              CircularProgressIndicator(),
              SizedBox(height: 800)
            ],
          );
        }
        return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
      })
    ]);
  }

  int _i = 5;

  Widget _buildVersion() {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            _i = _i - 1;
            print(_i);
            if (_i == 0) {
              launchURL(my_url);
              _i = 5;
            }
          },
          child: Text(
            ' Version 1.1.2 ',
            style: TextStyle(
              fontSize: 12.0,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.grey,
              // background: Paint()..color = Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLove() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        'Made with ♥ in Rothenburg',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald',
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading:
                Image.asset('assets/goslergrend.png', fit: BoxFit.fitHeight),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/diadamas.png',
                    height: 40,
                  )
                ],
              ),
              centerTitle: true,
              /*   title: Image.asset(
                'assets/diadamas.png',
                height: 30,
                fit: BoxFit.fitHeight,
              ), */
              background: Image.asset(
                'assets/appBarJubi.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(Icons.event),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ticker');
                  },
                ),
              ),
            ],
          ),
          SliverList(
              delegate: new SliverChildListDelegate([
            Column(
              children: <Widget>[
                _buildNewsList(),
                _buildLove(),
                _buildVersion(),
                Image.asset(
                  'assets/zapfen.png',
                  fit: BoxFit.fitWidth,
                ),
              ],
            )
          ])
              /*  SliverFillRemaining(
            child: Container(child: _buildNewsList()),*/
              ),
        ],
      ),
    );
  }
}
