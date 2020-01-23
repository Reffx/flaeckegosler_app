import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/rendering.dart';

import './pages/news/news.dart';
import './pages/news/newsFasnacht.dart';
import './pages/auth.dart';
import './pages/info.dart';
import './pages/programm.dart';
import './pages/ticker.dart';
import './pages/event_admin.dart';
import './scoped-models/main.dart';
import './pages/single_news.dart';
import './models/news.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  final MainModel test = MainModel();

  bool _isAuthenticated = false;

  void initState() {
    //  _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
        // test.fetchFasnacht();
      });
    });
    super.initState();
  }

  build(BuildContext context) {
    //  return ScopedModelDescendant<MainModel>(
//        builder: (BuildContext context, Widget child, MainModel test) {
    //  String myFasnachtStart = test.fasnachtDateStart;
    //    String myFasnachtEnd = test.fasnachtDateEnd;
    // print(myFasnachtStart);
    // print(myFasnachtEnd);
    String v = "2019-02-24 00:01:00";

    if (DateTime.parse(v).isAfter(DateTime.now())) {
      return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              accentColor: Colors.grey,
              buttonColor: Colors.red),
          // home: AuthPage(), //only works wihtout '/' not used
          routes: {
            '/': (BuildContext context) => NewsPage(_model),
            '/news': (BuildContext context) => NewsPage(_model),
            '/info': (BuildContext context) => InfoPage(),
            '/programm': (BuildContext context) => ProgrammPage(),
            '/ticker': (BuildContext context) => TickerPage(_model),
            '/auth': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : EventAdminPage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'specific_news') {
              final String newsId = pathElements[2];
              final News news = _model.allNews.firstWhere((News news) {
                return news.id == newsId;
              });
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => SingleNews(news),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) => NewsPage(_model));
          },
        ),
      );
    } else {
      return
          //DateTime.parse(v).isBefore(DateTime.now())
          ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: ThemeData(
              //brightness: Brightness.dark,
              primarySwatch: Colors.brown,
              accentColor: Colors.brown,
              buttonColor: Colors.white),
          // home: AuthPage(), //only works wihtout '/' not used
          routes: {
            '/': (BuildContext context) => NewsPageFasnacht(_model),
            '/news': (BuildContext context) => NewsPageFasnacht(_model),
            '/info': (BuildContext context) => InfoPage(),
            '/ticker': (BuildContext context) => TickerPage(_model),
            '/programm': (BuildContext context) => ProgrammPage(),
            '/auth': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : EventAdminPage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'specific_news') {
              final String newsId = pathElements[2];
              final News news = _model.allNews.firstWhere((News news) {
                return news.id == newsId;
              });
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => SingleNews(news),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) => NewsPageFasnacht(_model));
          },
        ),
      );
    }
//    });
  }
}
