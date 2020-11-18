import 'package:flutter/material.dart';

class Event {
  final String id;
  final String playTime;
  final String predictedPlayTime;
  final String location;
  final String city;
  final String userEmail;
  final String userId;

  Event({
    @required this.id,
    @required this.playTime,
    @required this.predictedPlayTime,
    @required this.location,
    @required this.city,
    @required this.userEmail,
    @required this.userId,
  });
}
