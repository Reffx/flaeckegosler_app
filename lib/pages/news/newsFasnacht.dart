import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../models/news.dart';
import '../../widgets/countdown/countdown.dart';
import '../../widgets/ui_elements/madeWithLove.dart';
import '../../widgets/news/newsWidget.dart';
import '../../provider/newsProvider.dart';
import '../../provider/fasnachtsDatesProvider.dart';

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
  bool _show = true; //needed for handling the show of the FabCircularMenu
  ScrollController _scrollController =
      new ScrollController(); //needed for handling the show of the FabCircularMenu
  ScrollController _scrollController2 = new ScrollController();

  @override
  initState() {
    _fetchProducts();
    super.initState();
    handleScroll(); //needed for handling the show of the FabCircularMenu
  }

  _fetchProducts() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<NewsProvider>(context, listen: false).fetchProducts();
      await Provider.of<FasnachtsDatesProvider>(context, listen: false)
          .fetchFasnacht();
      /* if (Provider.of<NewsProvider>(context, listen: false)
          .allNews
          .isNotEmpty) {
        await Provider.of<FasnachtsDates>(context, listen: false)
            .fetchFasnacht();  
        } */
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
      Provider.of<FasnachtsDatesProvider>(context).fetchFasnacht();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  //needed for handling the show of the FabCircularMenu
  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  Widget _buildNewsList(isNewLayout) {
    List<News> _allNews =
        Provider.of<NewsProvider>(context, listen: false).allNews;
    if (_allNews.length > 0) {
      return ListView(
        shrinkWrap: true,
        controller: _scrollController2,
        children: <Widget>[
          Countdown(),
          NewsWidget(news: _allNews),
          MadeWithLoveWidget(),
          _buildVersion(),
          _getImageBottom(isNewLayout),
        ],
      );
    } else {
      return ListView(
        shrinkWrap: true,
        controller: _scrollController2,
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                    'Keine Artikel gefunden! Überprüfe deine Internetverbindung!'),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height),
            ),
          )
        ],
      );
    }
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
            ' Version 1.3.1 ',
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

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  } //needed for handling the show of the FabCircularMenu

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  } //needed for handling the show of the FabCircularMenu

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  } //needed for handling the show of the FabCircularMenu

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: _show ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Visibility(
            visible: _show,
            child: FabCircularMenu(
              fabColor: Theme.of(context).primaryColor,
              fabOpenIcon: Icon(Icons.menu, color: Colors.white),
              fabCloseIcon: Icon(Icons.close, color: Colors.white),
              fabMargin: EdgeInsets.all(16.0),
              alignment: Alignment.bottomLeft,
              ringWidth: 50,
              ringDiameter: 300,
              ringColor: Theme.of(context).primaryColor,
              children: <Widget>[
                RawMaterialButton(
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ticker');
                  },
                ),
                RawMaterialButton(
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.event,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/programm');
                  },
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          displacement: 80,
          onRefresh: test,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
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
                /* actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.event),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ticker');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.view_week),
                    onPressed: () {
                      Navigator.pushNamed(context, '/programm');
                    },
                  ),
                ],*/
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _isLoading
                        ? Center(
                            child: Container(
                            padding: EdgeInsets.only(top: 200.0),
                            child: CircularProgressIndicator(),
                          ))
                        : _buildNewsList(widget.isNewLayout),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
