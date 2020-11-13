import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

const my_url = 'https://flaeckegosler.ch/admin';
int _i = 5;
int _k = 5;

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print('Could not launch $url');
  }
}

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoPageState();
  }
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.only(bottom: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
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
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald',
                        color: Colors.white,
                        background: Paint()..color = Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22),
              Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _k = _k - 1;
                      print(_k);
                      if (_k == 0) {
                        Navigator.pushNamed(context, '/auth');
                        _k = 5;
                      }
                    },
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
