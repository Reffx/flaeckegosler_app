import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FasnachtsDate with ChangeNotifier {
  final String id;
  final String start;
  final String end;

 FasnachtsDate( 
      {@required this.id,
      @required this.start,
      @required this.end,
      });
}

class FasnachtsDates with ChangeNotifier {
  List<FasnachtsDate> _fasnachtsDates = [];

  List<FasnachtsDate> get fasnachtsDates {
    return [..._fasnachtsDates];
  }
  
  String get fasnachtDateStart {
    return _fasnachtsDates.first.start;
  }

  String get fasnachtDateEnd {
    return _fasnachtsDates.first.end;
  }

  Future<void> fetchFasnacht() async {
    const url =
        'https://flutter-products-6da30.firebaseio.com/fasnachtDate.json';
    try {
      final response = await http.get(url);
      final List<FasnachtsDate> fetchedFasnachtsDate = [];
      final Map<String, dynamic> dateListData = json.decode(response.body);
      dateListData.forEach((String dateId, dynamic dateData) {
        final FasnachtsDate date = FasnachtsDate(
          id: dateId.toString(),
          start: dateData['startDate'],
          end: dateData['endDate'],
        );
        fetchedFasnachtsDate.add(date);
      });
      _fasnachtsDates = fetchedFasnachtsDate;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
