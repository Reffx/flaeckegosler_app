import 'package:flutter/material.dart';

import '../../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int eventIndex;

  EventCard(this.event, this.eventIndex);

  Widget _buildEventRowTime() {
    return Row(children: <Widget>[
      Container(
        child: Text(
          ' ' + event.playTime + ' ',
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
        padding: EdgeInsets.only(left: 60, top: 10),
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
        padding: EdgeInsets.only(left: 120, top: 10),
        child: Text(
          ' ' + event.city + ' ',
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

  @override
  Widget build(BuildContext context) {
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
  }
}
