import 'package:Flaeckegosler/models/pictures.dart';
import 'package:Flaeckegosler/provider/picturesProvider.dart';
import 'package:Flaeckegosler/widgets/news/galleryCard.dart';
import 'package:provider/provider.dart';

import './../../models/news.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  final News singleNews;
  Gallery(this.singleNews);
  @override
  State<StatefulWidget> createState() {
    return _GalleryState(singleNews);
  }
}

class _GalleryState extends State<Gallery> {
  final News singleNews;
  _GalleryState(this.singleNews);

  var _isLoading = false;

  @override
  initState() {
    _fetchPicturesList();
    super.initState();
  }

  _fetchPicturesList() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<PicturesProvider>(context, listen: false)
          .fetchPicturesList()
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
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        GalleryCard(singleNews),
        GalleryCard(singleNews),
        GalleryCard(singleNews),
      ],
    );
    // TODO: implement build
  }
}
