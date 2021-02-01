import 'package:Flaeckegosler/pages/Schnitzeljadg/models/place.dart';
import 'package:Flaeckegosler/pages/Schnitzeljadg/models/placeProvider.dart';
import 'package:Flaeckegosler/pages/Schnitzeljadg/quizzMap.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';

class SimplePhotoViewPage extends StatefulWidget {
  final String galleryLink;

  SimplePhotoViewPage(this.galleryLink);

  @override
  _SimplePhotoViewPageState createState() => _SimplePhotoViewPageState();
}

class _SimplePhotoViewPageState extends State<SimplePhotoViewPage> {
  PhotoViewController controller;

  @override
  void initState() {
    super.initState();
    controller = PhotoViewController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getRotation() {
    setState(() {
      controller.rotation;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.galleryLink ==
        'https://flaeckegosler.ch/site/assets/files/2446/waykicki.jpg') {
      String reportedByName;
      return Scaffold(
        appBar: AppBar(
          title: Text(''),
          /*  actions: <Widget>[                       //Wegen der Schnitzeljadg deaktiviert
          IconButton(
            icon: Icon(
              Icons.announcement_rounded,
              color: Colors.white,
            ),
            onPressed: () => reportPictureDialog(context, widget.galleryLink),
          )
        ],*/
        ),
        body: GestureDetector(
          onTapCancel: () {
            setState(() {
              _getRotations();
            });
          },
          child: Stack(
            children: <Widget>[
              PhotoView(
                controller: controller,
                imageProvider: NetworkImage(
                  widget.galleryLink,
                ),
                // Contained = the smallest possible size to fit one dimension of the screen
                minScale: PhotoViewComputedScale.contained * 0.8,
                // Covered = the smallest possible size to fit the whole screen
                maxScale: PhotoViewComputedScale.covered * 2,
                enableRotation: true,
                // Set the background color to the "classic white"
                backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
              ),
              _getStack(),
              Container(
                child: _getRotations(),
                alignment: Alignment.topCenter,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.announcement_rounded,
                color: Colors.white,
              ),
              onPressed: () => reportPictureDialog(context, widget.galleryLink),
            )
          ],
        ),
        body: PhotoView(
          imageProvider: NetworkImage(
            widget.galleryLink,
          ),
          // Contained = the smallest possible size to fit one dimension of the screen
          minScale: PhotoViewComputedScale.contained * 0.8,
          // Covered = the smallest possible size to fit the whole screen
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: true,
          // Set the background color to the "classic white"
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
        ),
      );
    }
  }

  _getRotations() {
    return FlatButton(
      onPressed: () => {
        print(controller.rotation),
        setState(() {
          controller.rotation;
        })
      },
      child: getSickText(controller.rotation),
    );
  }

  getSickText(rotation) {
    if (rotation <= 0) {
      return Text(
        "😌: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    } else if (rotation < 4) {
      return Text(
        "😑: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    } else if (rotation < 12) {
      return Text(
        "😖: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    } else if (rotation < 18) {
      return Text(
        "😵: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    } else if (rotation < 24) {
      return Text(
        "🤢: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    } else {
      return Text(
        "🤮: " + controller.rotation.toString(),
        style: TextStyle(fontSize: 25),
      );
    }
  }

  _getStack() {
    var _latitude = Provider.of<PlaceProvider>(context, listen: false)
        .allEvents
        .elementAt(2)
        .latitude;
    var _longitude = Provider.of<PlaceProvider>(context, listen: false)
        .allEvents
        .elementAt(2)
        .longitude;
    if (controller.rotation > 30.0) {
      return Center(
        child: AlertDialog(
          title: Text("Mir ist ganz schwindelig! 🤮🤮🤮"),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => QuizzMap(
                    initialLocation: PlaceLocation(
                        latitude: _latitude, longitude: _longitude),
                    isSelecting: false,
                  ),
                ),
              ),
              child: Text("Okay"),
            ),
          ],
          elevation: 24,
        ),
      );
    } else
      return Container();
  }
}

//Die folgenden Methoden sind zur Meldung der Bildern notwendig!
reportPictureDialog(context, galleryLink) {
  TextEditingController _textFieldController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Bild melden?"),
      content: TextField(
        controller: _textFieldController,
        textInputAction: TextInputAction.go,
        //keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(hintText: "Dein Name..."),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Schliessen'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
        FlatButton(
          child: Text('Senden'),
          onPressed: () => {
            if (_textFieldController.text.isEmpty)
              {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(""),
                    content: Text('Name benötigt!'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Schliessen'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                )
              }
            else
              {
                sendMail(context, galleryLink, _textFieldController.text),
              }
          },
        ),
      ],
    ),
  );
}

sendMail(context, galleryLink, reportedByName) async {
  Navigator.of(context).pop();

  String username = 'instagram.flaeckegosler@gmail.com';
  String password = 'schmitte1291';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'GoslerApp')
    ..recipients.add('ripsli@hotmail.com')
    ..subject = 'Report image :: 😀 :: ${DateTime.now()}'
    ..html =
        "<h1>Image report</h1>\n<p>Hey! Mein name ist $reportedByName und ich würde gerne Foto $galleryLink löschen lassen</p>";

  try {
    final sendReport = await send(message, smtpServer);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Erfolgreich gemeldet!"),
        content:
            Text("Habe ein bisschen Geduld, deine Meldung wird nun geprüft!"),
        actions: <Widget>[
          FlatButton(
            child: Text('Schliessen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  } on Exception {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Fehler!"),
        content: Text("Überprüfe deine Internetverbindung."),
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
  }
}
