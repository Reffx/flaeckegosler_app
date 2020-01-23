import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/news.dart';

import 'package:flutter_html/flutter_html.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print('Could not launch $url');
  }
}

class SingleNews extends StatelessWidget {
  final News single_news;

  SingleNews(this.single_news);

  String getRedakteur() {
    if (single_news.newsCreatedBy == "Administrator") {
      return null;
    } else if (single_news.newsCreatedBy == "Carmen Andermatt") {
      return 'assets/redakteure/carmen.png';
    } else if (single_news.newsCreatedBy == "Damian Zurmühle") {
      return 'assets/redakteure/damian.png';
    } else if (single_news.newsCreatedBy == "Daniela Hotz") {
      return 'assets/redakteure/danielah.png';
    } else if (single_news.newsCreatedBy == "Dario Köchli") {
      return 'assets/redakteure/dariok.png';
    } else if (single_news.newsCreatedBy == "Dario Stocker") {
      return 'assets/redakteure/darios.png';
    } else if (single_news.newsCreatedBy == "Diego Zimmermann") {
      return 'assets/redakteure/diego.png';
    } else if (single_news.newsCreatedBy == "Dominic Mauron") {
      return 'assets/redakteure/dominicm.png';
    } else if (single_news.newsCreatedBy == "Fabian Koch") {
      return 'assets/redakteure/fabiank.png';
    } else if (single_news.newsCreatedBy == "Fabio Roos") {
      return 'assets/redakteure/fabio.png';
    } else if (single_news.newsCreatedBy == "Janick Lang") {
      return 'assets/redakteure/janick.png';
    } else if (single_news.newsCreatedBy == "José Stählin") {
      return 'assets/redakteure/jose.png';
    } else if (single_news.newsCreatedBy == "Justin Faesi") {
      return 'assets/redakteure/justin.png';
    } else if (single_news.newsCreatedBy == "Lukas Studer") {
      return 'assets/redakteure/lukasStuder.png';
    } else if (single_news.newsCreatedBy == "Manuel Mühlebach") {
      return 'assets/redakteure/manuelm.png';
    } else if (single_news.newsCreatedBy == "Martin Richli") {
      return 'assets/redakteure/martin.png';
    } else if (single_news.newsCreatedBy == "Michèle Kritzer") {
      return 'assets/redakteure/michelek.png';
    } else if (single_news.newsCreatedBy == "Noah Berwert") {
      return 'assets/redakteure/noah.png';
    } else if (single_news.newsCreatedBy == "Oliver Schürch") {
      return 'assets/redakteure/olivers.png';
    } else if (single_news.newsCreatedBy == "Patrick Vogel") {
      return 'assets/redakteure/patrickv.png';
    } else if (single_news.newsCreatedBy == "Philippe Schenker") {
      return 'assets/redakteure/phil.png';
    } else if (single_news.newsCreatedBy == "Raphael Koch") {
      return 'assets/redakteure/raphikoch.png';
    } else if (single_news.newsCreatedBy == "Reto Bättig") {
      return 'assets/redakteure/reto.png';
    } else if (single_news.newsCreatedBy == "Stefan Lang") {
      return 'assets/redakteure/stefan.png';
    } else
      return null;
  }

  Widget _buildRedakteur() {
    if (getRedakteur() != null) {
      return Column(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
              child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(
                  getRedakteur(),
                ),
              ),
              Text("   von " + single_news.newsCreatedBy),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Divider()),
        ],
      );
    } else
      return SizedBox();
  }

  Widget _buildTitelBild() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: new Border(
          left: BorderSide(color: Colors.white, width: 10.0),
          top: BorderSide(color: Colors.white, width: 10.0),
          right: BorderSide(color: Colors.white, width: 10.0),
          bottom: BorderSide(color: Colors.white, width: 10.0),
        ),
        //borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        image: DecorationImage(
            image: NetworkImage(single_news.imageURL), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildImageDescription() {
    if (single_news.imageDescription != null) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          single_news.imageDescription,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
      );
    } else
      return SizedBox(
        height: 10,
      );
  }

  Widget _buildMainText() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
      child: Html(
        data: single_news.newsMainText,
        onLinkTap: (url) {
          if (url.startsWith('http') || url.startsWith('www')) {
            print(url.startsWith('http'));
            launchURL(url);
            print("Opening $url...");
          } else
            launchURL('https://flaeckegosler.ch/' + url);
          print("Opening $url...");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pushNamed(context, '/info');
              },
            )
          ], */
        ),
        body: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTitelBild(),
            _buildImageDescription(),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: TitleDefault(single_news.newsTitle),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.access_time, size: 12),
                  Text(" " + single_news.timeCreatedFormatted,
                      style: (TextStyle(fontSize: 10))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Html(
                data: "<b>" + single_news.newsIntroText + "</b>",
              ),
            ),
            _buildRedakteur(),
            _buildMainText(),
          ],
        ),
      ),
    );
  }
}
