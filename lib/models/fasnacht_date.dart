import 'package:flutter/material.dart';

class FasnachtsDate with ChangeNotifier {
  final String id;
  final String start;
  final String end;

  FasnachtsDate({
    @required this.id,
    @required this.start,
    @required this.end,
  });
}
