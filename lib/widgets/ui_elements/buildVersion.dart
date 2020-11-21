import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildVersion extends StatelessWidget {
  static const my_url = 'https://flaeckegosler.ch/admin';

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    int _i = 5;
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
            ' Version 1.3.2 ',
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
}
