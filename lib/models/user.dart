import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String token;
  final String instrument;
  final String userType;

  User({
    @required this.id,
    @required this.email,
    @required this.token,
    @required this.instrument,
    @required this.userType,
  });
}
