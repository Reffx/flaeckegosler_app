import 'package:Flaeckegosler/models/fasnacht_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main.dart';

import './pages/news/newsFasnacht.dart';
import './pages/auth.dart';
import './pages/info.dart';
import './pages/programm.dart';
import './pages/ticker.dart';
import './pages/event_admin.dart';
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

  bool _isAuthenticated = false;

  void initState() {
    //  _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
        //test.fetchFasnacht();
      });
    });
    super.initState();
  }

  build(BuildContext context) {
    //String y = _model.fasnachtDateStart;
    String v = "2020-02-20 05:00:00";
    bool isNewLayout = DateTime.parse(v).isBefore(DateTime.now());

    var myThemeData = getThemeData(isNewLayout);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FasnachtsDates(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child:
          //DateTime.parse(v).isBefore(DateTime.now())
          ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: myThemeData,
          // home: AuthPage(), //only works wihtout '/' not used
          routes: {
            '/': (BuildContext context) => NewsPageFasnacht(isNewLayout),
            '/news': (BuildContext context) => NewsPageFasnacht(isNewLayout),
            '/info': (BuildContext context) => InfoPage(),
            '/ticker': (BuildContext context) =>
                TickerPage(_model, isNewLayout),
            '/programm': (BuildContext context) => ProgrammPage(isNewLayout),
            '/auth': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : EventAdminPage(),
          },
          onGenerateRoute: (RouteSettings settings) {
            List<News> test = settings.arguments;
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'specific_news') {
              final String newsId = pathElements[2];
              final News news = test.firstWhere((News newsss) {
                return newsss.id == newsId;
              });
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => SingleNews(news),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) =>
                    NewsPageFasnacht(isNewLayout));
          },
        ),
      ),
    );
  }

  getThemeData(bool isNewLayout) {
    if (isNewLayout) {
      return ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple,
          buttonColor: Colors.white);
    } else {
      return ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Colors.brown,
          buttonColor: Colors.white);
    }
  }
}
