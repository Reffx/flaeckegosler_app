import 'package:Flaeckegosler/models/fasnacht_date.dart';
import 'package:Flaeckegosler/widgets/countdown/countdown.dart';
import 'package:Flaeckegosler/widgets/ui_elements/madeWithLove.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

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
  var _isInit = true;

  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

    @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<FasnachtsDates>(context).fetchFasnacht();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _buildNewsList() {
    return Container(
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(
            child: Text(
                'Keine Artikel gefunden! Überprüfe deine Internetverbindung!'),
          );
          if (model.allNews.length > 0 && !model.isLoading) {
            content = ListView(
              children: <Widget>[
              Countdown(),
              NewsWidget(),
              MadeWithLoveWidget(),
              _buildVersion(),
               Image.asset(
                'assets/zapfen.png',
                fit: BoxFit.fitWidth,
              ) 
            ]);
          } else if (model.isLoading) {
            content = Container(); //if it's loading return empty container
          }
          return RefreshIndicator(
            onRefresh: model.fetchProducts, child: content);
        },
      ),
    );
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
            ' Version 1.2.1 ',
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
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
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
              background: Image.asset(
                'assets/appBarJubi.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.event),
                onPressed: () {
                  Navigator.pushNamed(context, '/ticker');
                },
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.pushNamed(context, '/programm');
                },
              ),
            ],
          ),
        ],
        body: _buildNewsList(),
      ),
    );
  }
}
