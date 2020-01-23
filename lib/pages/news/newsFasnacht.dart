import 'package:flutter/material.dart';

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
  @override
  initState() {
    widget.model.fetchFasnacht();
    widget.model.fetchProducts();
    super.initState();
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
            content = ListView(children: <Widget>[
              _countdown(),
              NewsWidget(),
              _buildLove(),
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

  Widget _countdown() {
    return Container(
      child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (DateTime.parse(model.fasnachtDateStart).isAfter(DateTime.now())) {
          var date1 = DateTime.parse(model.fasnachtDateStart);
          var _counterSeconds = date1.difference(DateTime.now()).inSeconds % 60;
          var _counterMinutes = date1.difference(DateTime.now()).inMinutes % 60;
          var _counterHours = date1.difference(DateTime.now()).inHours % 24;
          var _counterDays = date1.difference(DateTime.now()).inDays;
          String _days;
          if (_counterDays == 1) {
            _days = 'Tag';
          } else {
            _days = 'Tage';
          }
          String _hours;
          if (_counterHours == 1) {
            _hours = 'Stunde';
          } else {
            _hours = 'Stunden';
          }
          String _minutes;
          if (_counterMinutes == 1) {
            _minutes = 'Minute';
          } else {
            _minutes = 'Minuten';
          }
          String _seconds;
          if (_counterSeconds == 1) {
            _seconds = 'Sekunde';
          } else {
            _seconds = 'Sekunden';
          }
          Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
              _counterSeconds--;
              _seconds = 'doumb';
            });
          });
          Timer.periodic(Duration(minutes: 1), (timer) {
            setState(() {
              _counterMinutes--;
            });
          });
          Timer.periodic(Duration(hours: 1), (timer) {
            setState(() {
              _counterHours--;
            });
          });
          Timer.periodic(Duration(days: 1), (timer) {
            setState(() {
              _counterDays--;
            });
          });
          return Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Container(
                height: 30,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    ' ${_counterDays} ${_days}, ${_counterHours} ${_hours}, ${_counterMinutes} ${_minutes}, ${_counterSeconds} ${_seconds} ',
                    style: TextStyle(
                      height: 1.6,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald',
                      color: Colors.white,
                      background: Paint()..color = Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 0,
          );
        }
      }),
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
