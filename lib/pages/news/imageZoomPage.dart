import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SimplePhotoViewPage extends StatelessWidget {
  final String galleryLink;

  SimplePhotoViewPage(this.galleryLink);

  @override
  Widget build(BuildContext context) {
    String reportedByName;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.announcement_rounded,
              color: Colors.white,
            ),
            onPressed: () => reportPictureDialog(context, galleryLink),
          )
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(
          galleryLink,
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
