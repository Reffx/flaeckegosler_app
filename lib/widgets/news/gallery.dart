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

  // ignore: unused_field
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

  List<Widget> _createGallery(singleNews) {
    final List<Widget> test = [];
    double width =
        MediaQuery.of(context).size.width; //+12 padding build gallery
    if (_isLoading == true) {
      test.add(
        Container(
          padding: EdgeInsets.only(left: (width / 2) - 12 - 30 - 6),
          child: Center(
              child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(),
          )),
        ),
      );
      return test;
    } else {
      var allPictures =
          Provider.of<PicturesProvider>(context, listen: false).allPictures;
      for (int temp = 0; temp < allPictures.length; temp++) {
        if (allPictures[temp].albumTitle == singleNews.galleryLink) {
          for (int temp2 = 0;
              temp2 < allPictures[temp].specificImage.length;
              temp2++) {
            test.add(GalleryCard(singleNews,
                allPictures[temp].specificImage[temp2].pictureLink));
          }
        }
      }
      return test;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        ..._createGallery(singleNews),
      ],
    );
  }
}
