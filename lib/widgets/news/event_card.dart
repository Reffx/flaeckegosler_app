import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/event.dart';
import '../../scoped-models/main.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int eventIndex;

  EventCard(this.event, this.eventIndex);

  Widget _buildEventRowTime() {
    if (event.playTime.startsWith("2019")) {
      var formatter = new DateFormat("H:mm");
      DateTime v = DateTime.parse(event.playTime);
      String x = formatter.format(v);
      return Row(children: <Widget>[
        Container(
          child: Text(
            ' ' + x + ' Uhr ',
            textAlign: TextAlign.start,
            style: TextStyle(
              height: 1.2,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              background: Paint()..color = Colors.white,
            ),
          ),
        ),
      ]);
    } else
      return Row(children: <Widget>[
        Container(
          child: Text(
            event.playTime,
            textAlign: TextAlign.start,
            style: TextStyle(
              height: 1.2,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              background: Paint()..color = Colors.white,
            ),
          ),
        ),
      ]);
  }

  Widget _buildEventRowLocation() {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 60),
        child: Text(
          ' ' + event.location + ' ',
          textAlign: TextAlign.start,
          style: TextStyle(
            height: 1.2,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Oswald',
            color: Colors.black,
            background: Paint()..color = Colors.white,
          ),
        ),
      ),
    ]);
  }

  Widget _buildEventRowCity() {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 120),
        child: Text(
          ' ' + event.city + ' ',
          textAlign: TextAlign.start,
          style: TextStyle(
            height: 1.3,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Oswald',
            color: Colors.black,
            background: Paint()..color = Colors.white,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildEventRowTime(),
              _buildEventRowLocation(),
              _buildEventRowCity(),
            ],
          ),
        ),
      );
    });
  }
}
