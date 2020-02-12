import 'dart:async';

import 'package:Flaeckegosler/models/fasnacht_date.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Countdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  var _counterSeconds;
  var _counterMinutes;
  var _counterHours;
  var _counterDays;

  @override
  initState() {
    super.initState();       
  }

  @override
  Widget build(BuildContext context) {
    final myFasnachtDate = Provider.of<FasnachtsDates>(context, listen: false);
    if (DateTime.parse(myFasnachtDate.fasnachtDateStart)
        .isAfter(DateTime.now())) {
      var date1 = DateTime.parse(myFasnachtDate.fasnachtDateStart);
      _counterSeconds = date1.difference(DateTime.now()).inSeconds % 60;
      _counterMinutes = date1.difference(DateTime.now()).inMinutes % 60;
      _counterHours = date1.difference(DateTime.now()).inHours % 24;
      _counterDays = date1.difference(DateTime.now()).inDays;
      String _days;
       Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted){
       setState(() {
          --_counterSeconds;
             }); 
        }
      }); 
       
       if (_counterDays == 1) {
        _days = 'Tag';
      } else {
        _days = 'Tage';
      }
      String _hours;
      if (_counterHours == 1) {
        _hours = 'Stunde';
      } else {
        _hours = 'Stunden';
      }
      String _minutes;
      if (_counterMinutes == 1) {
        _minutes = 'Minute';
      } else {
        _minutes = 'Minuten';
      }
      String _seconds;
      if (_counterSeconds == 1) {
        _seconds = 'Sekunde';
      } else {
        _seconds = 'Sekunden';
      } 
      return Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          child: Container(
            height: 30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                ' ' +' ${_counterDays} ${_days}, ${_counterHours} ${_hours}, ${_counterMinutes} ${_minutes}, ${_counterSeconds} ${_seconds} ' + ' ',
                style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald',
                  color: Colors.white,
                  background: Paint()..color = Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
    ;
  }
}
