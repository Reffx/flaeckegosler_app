import 'package:Flaeckegosler/pages/Schnitzeljadg/fettquiz.dart';
import 'package:Flaeckegosler/pages/Schnitzeljadg/models/placeProvider.dart';
import 'package:Flaeckegosler/pages/news/imageZoomPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import './pages/news/news_list.dart';
import './pages/authScreen.dart';
import './pages/programm.dart';
import './pages/event/event_ticker.dart';
//import './pages/event/event_admin.dart';
import './pages/news/news_single.dart';

import './provider/authProvider.dart';

import './models/news.dart';
import './provider/fasnachtsDatesProvider.dart';
import './provider/newsProvider.dart';
import './provider/eventProvider.dart';
import './provider/picturesProvider.dart';
import 'pages/Schnitzeljadg/secretCode.dart';
import 'pages/authorization/userHome.dart';

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
  bool _isAuthenticated = false;

  void initState() {
    super.initState();
  }

  build(BuildContext context) {
    //String y = _model.fasnachtDateStart;
    String v = "2020-02-20 05:00:00";
    bool isNewLayout = DateTime.parse(v).isBefore(DateTime.now());

    var myThemeData = getThemeData(isNewLayout);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FasnachtsDatesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PicturesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlaceProvider(),
        ),
      ],
      child:
          //DateTime.parse(v).isBefore(DateTime.now())
          MaterialApp(
        theme: myThemeData,
        //home: AuthPage(), //only works wihtout '/' not used
        routes: {
          '/': (BuildContext context) => NewsPageFasnacht(isNewLayout),
          '/news': (BuildContext context) => NewsPageFasnacht(isNewLayout),
          '/ticker': (BuildContext context) => TickerPage(isNewLayout),
          '/programm': (BuildContext context) => ProgrammPage(isNewLayout),
          '/userHome': (BuildContext context) => UserHome(),
          '/secretCode': (BuildContext context) => SecretCodePage(),
          '/fettQuizz': (BuildContext context) => FettQuizzPage(),
          '/auth': (BuildContext context) =>
              !_isAuthenticated ? AuthScreen() : AuthScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          News test;
          String galleryLink;
          if (settings.arguments is News) {
            test = settings.arguments;
          } else if (settings.arguments is String) {
            galleryLink = settings.arguments;
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'specific_news') {
            // final String newsId = pathElements[2];
            // final News news = test.firstWhere((News newsss) {
            //   return newsss.id == newsId;
            ///   });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => SingleNews(test),
            );
          } else if (pathElements[1] == 'specific_image') {
            //final String galleryLink = pathElements[2];
            // final News news = test.firstWhere((News newsss) {
            //  return newsss.galleryLink == galleryLink;
            // });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  SimplePhotoViewPage(galleryLink),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => NewsPageFasnacht(isNewLayout));
        },
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
