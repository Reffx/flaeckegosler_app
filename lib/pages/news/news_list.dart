import 'package:Flaeckegosler/pages/Schnitzeljadg/models/placeProvider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../models/news.dart';
import '../../widgets/countdown/countdown.dart';
import '../../widgets/ui_elements/madeWithLove.dart';
import '../../widgets/news/newsWidget.dart';
import '../../widgets/ui_elements/buildVersion.dart';
import '../../provider/newsProvider.dart';
import '../../provider/fasnachtsDatesProvider.dart';
import '../../provider/authProvider.dart';

import '../../layout/backgroundImage.dart';
import '../../layout/footerImage.dart';
import '../../layout/navBarImageTitle.dart';

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
    Provider.of<AuthProvider>(context, listen: false).tryAutoLogin();
    _fetchNewsList();
    super.initState();
    handleScroll(); //needed for handling the show of the FabCircularMenu
  }

  _fetchNewsList() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<NewsProvider>(context, listen: false)
          .fetchNewsList()
          .catchError(
        (error) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Fehler beim Laden!"),
              content: Text("Überprüfe deine Internetverbindung!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Schliessen'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
      await Provider.of<FasnachtsDatesProvider>(context, listen: false)
          .fetchFasnacht();
      //Used for schnitzeljadg
      Provider.of<PlaceProvider>(context, listen: false).fetchPlaces();
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
    _fetchNewsList();
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
          BuildVersion(),
          FooterImage(isNewLayout),
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

  EdgeInsets _getTitlePadding(bool isNewLayout) {
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
                leading: GestureDetector(
                  child: Image.asset(
                    'assets/goslergrend.png',
                    fit: BoxFit.fitHeight,
                  ),
                  onLongPress: () =>
                      {Navigator.pushNamed(context, '/secretCode')},
                ),
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 120.0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: _getTitlePadding(widget.isNewLayout),
                  title: NavBarImageTitle(widget.isNewLayout),
                  centerTitle: true,
                  background: BackgroundImage(widget.isNewLayout),
                ),
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
