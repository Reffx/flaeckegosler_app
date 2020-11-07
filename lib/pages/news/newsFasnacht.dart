import 'package:Flaeckegosler/models/fasnacht_date.dart';
import 'package:Flaeckegosler/models/news.dart';
import 'package:Flaeckegosler/widgets/countdown/countdown.dart';
import 'package:Flaeckegosler/widgets/ui_elements/madeWithLove.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../../widgets/news/newsWidget.dart';

const my_url = 'https://flaeckegosler.ch/admin';

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print('Could not launch $url');
  }
}

class NewsPageFasnacht extends StatefulWidget {
  final bool isNewLayout;
  NewsPageFasnacht(this.isNewLayout);
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPageFasnacht> {
  var _isLoading = false;
  var _isInit = true;

  @override
  initState() {
    _fetchProducts();
    super.initState();
  }

  _fetchProducts() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<NewsProvider>(context, listen: false).fetchProducts();
      await Provider.of<FasnachtsDates>(context, listen: false).fetchFasnacht();
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<Null> test() async {
    _fetchProducts();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // Provider.of<NewsProvider>(context).fetchProducts();
      //Provider.of<FasnachtsDates>(context).fetchFasnacht();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _buildNewsList(isNewLayout) {
    Widget content = Center();
    List<News> _allNews =
        Provider.of<NewsProvider>(context, listen: false).allNews;
    if (_allNews.length > 0) {
      content = ListView(children: <Widget>[
        Countdown(),
        NewsWidget(news: _allNews),
        MadeWithLoveWidget(),
        _buildVersion(),
        _getImageBottom(isNewLayout),
      ]);
    } else {
      content = Center(
        child:
            Text('Keine Artikel gefunden! Überprüfe deine Internetverbindung!'),
      );
    }
    return RefreshIndicator(onRefresh: test, child: content);
    //
    /* Widget content = Center(
      child:
          Text('Keine Artikel gefunden! Überprüfe deine Internetverbindung!'),
    );
    if (Provider.of<NewsProvider>(context, listen: false).allNews.length > 0) {
      content = ListView(children: <Widget>[
        Countdown(),
        NewsWidget(),
        MadeWithLoveWidget(),
        _buildVersion(),
        _getImageBottom(isNewLayout),
      ]);
    } else if (newsProviderVar.isLoading) {
      content = Container(); //if it's loading return empty container
    }
    return RefreshIndicator(
        onRefresh: newsProviderVar.fetchProducts, child: content); */
    // return Container();
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
            ' Version 1.3.0 ',
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

  Image _getImageBottom(bool isNewLayout) {
    if (isNewLayout) {
      return Image.asset(
        'assets/layout_2020/news_bottom.png',
        fit: BoxFit.fitWidth,
      );
    } else
      return Image.asset(
        'assets/zapfen.png',
        fit: BoxFit.fitWidth,
      );
  }

  Image getImageTitle(bool isNewLayout) {
    if (isNewLayout) {
      return Image.asset(
        'assets/layout_2020/goslermythos_title.png',
        height: 50,
      );
    } else
      return Image.asset(
        'assets/diadamas.png',
        height: 40,
      );
  }

  Image getBackgroundImage(bool isNewLayout) {
    if (isNewLayout) {
      return Image.asset(
        'assets/layout_2020/MUSTER_REPETIEREND_apptitle.png',
        fit: BoxFit.fitWidth,
      );
    } else {
      return Image.asset(
        'assets/appBarJubi.png',
        fit: BoxFit.fitHeight,
      );
    }
  }

  EdgeInsets getTitlePadding(bool isNewLayout) {
    if (isNewLayout) {
      return EdgeInsets.only(top: 5, bottom: 5);
    } else {
      return EdgeInsets.only(top: 5, bottom: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: new NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
                  SliverAppBar(
                    leading: Image.asset('assets/goslergrend.png',
                        fit: BoxFit.fitHeight),
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 120.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: getTitlePadding(widget.isNewLayout),
                      title: getImageTitle(widget.isNewLayout),
                      centerTitle: true,
                      background: getBackgroundImage(widget.isNewLayout),
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
            body: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildNewsList(widget.isNewLayout)),
      ),
    );
  }
}

/*
FutureBuilder(
      future: Provider.of<NewsProvider>(context, listen: false).fetchProducts(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot != null) {
            Center(
              child: Text(
                  'Keine Artikel gefunden! Überprüfe deine Internetverbindung!'),
            );
          } else {
            return Consumer<NewsProvider>(
              builder: (ctx, newsProviderData, child) {
                return ListView(children: <Widget>[
                  Countdown(),
                  NewsWidget(news: newsProviderData.allNews),
                  MadeWithLoveWidget(),
                  _buildVersion(),
                  _getImageBottom(isNewLayout),
                ]);
              },
            );
          }
        }
        return Consumer<NewsProvider>(
          builder: (ctx, newsProviderData, child) {
            return ListView(children: <Widget>[
              Countdown(),
              NewsWidget(news: newsProviderData.allNews),
              MadeWithLoveWidget(),
              _buildVersion(),
              _getImageBottom(isNewLayout),
            ]);
          },
        );
      },
    );
 */
