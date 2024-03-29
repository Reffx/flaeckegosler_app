import 'package:Flaeckegosler/widgets/news/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../../models/news.dart';
import '../../widgets/news/buildRedakteur.dart';
import '../../widgets/ui_elements/title_default.dart';

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: false);
  } else {
    print('Could not launch $url');
  }
}

class SingleNews extends StatelessWidget {
  final News singleNews;

  SingleNews(this.singleNews);

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
            image: NetworkImage(singleNews.imageURL), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildImageDescription() {
    if (singleNews.imageDescription != null) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          singleNews.imageDescription,
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
        data: singleNews.newsMainText,
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

  Widget _buildGallery() {
    if (singleNews.galleryLink == "") {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: LimitedBox(
          maxHeight: 220,
          child: Gallery(singleNews),
        ),
      );
    }
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
              child: TitleDefault(singleNews.newsTitle),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.access_time, size: 12),
                  Text(" " + singleNews.timeCreatedFormatted,
                      style: (TextStyle(fontSize: 10))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Html(
                data: "<b>" + singleNews.newsIntroText + "</b>",
              ),
            ),
            buildRedakteur(singleNews.newsCreatedBy),
            _buildGallery(),
            _buildMainText(),
          ],
        ),
      ),
    );
  }
}
