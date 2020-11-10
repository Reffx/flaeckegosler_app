import 'package:flutter/material.dart';
import '../models/user.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

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

class EventProvider with ChangeNotifier {
  User _authenticatedUser;
  List<Event> _events = [];
  String _selEventId;

  List<Event> get allEvents {
    return List.from(_events);
  }

  int get selectedEventIndex {
    return _events.indexWhere((Event event) {
      return event.id == _selEventId;
    });
  }

  String get selectedEventId {
    return _selEventId;
  }

  Event get selectedEvent {
    if (selectedEventId == null) {
      return null;
    }
    return _events.firstWhere((Event event) {
      return event.id == _selEventId;
    });
  }

  Future<bool> addEvent(String playTime, String predictedPlayTime,
      String location, String city) async {
    final Map<String, dynamic> eventData = {
      'playTime': playTime,
      'predictedPlayTime': predictedPlayTime,
      'location': location,
      'city': city,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    try {
      final http.Response response = await http.post(
          'https://flutter-products-6da30.firebaseio.com/events.json?auth=${_authenticatedUser.token}',
          body: json.encode(eventData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Event newEvent = Event(
          id: responseData['name'],
          playTime: playTime,
          predictedPlayTime: predictedPlayTime,
          location: location,
          city: city,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _events.add(newEvent);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateEvent(
      String playTime, String predictedPlayTime, String location, String city) {
    final Map<String, dynamic> updateData = {
      'playTime': playTime,
      'predictedPlayTime': predictedPlayTime,
      'location': location,
      'city': city,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .put(
            'https://flutter-products-6da30.firebaseio.com/events/${selectedEvent.id}.json?auth=${_authenticatedUser.token}',
            body: json.encode(updateData))
        .then((http.Response response) {
      final Event updatedEvent = Event(
          id: selectedEvent.id,
          playTime: playTime,
          predictedPlayTime: predictedPlayTime,
          location: location,
          city: city,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _events[selectedEventIndex] = updatedEvent;
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> fetchEvents() {
    return http
        .get('https://flutter-products-6da30.firebaseio.com/events.json')
        .timeout(Duration(seconds: 6))
        .then<Null>((http.Response response) {
      final List<Event> fetchtedEventList = [];
      final Map<String, dynamic> eventListData = json.decode(response.body);
      if (eventListData == null) {
        return;
      }
      eventListData.forEach((String eventId, dynamic eventData) {
        final Event event = Event(
          id: eventId,
          playTime: eventData['playTime'],
          predictedPlayTime: eventData['predictedPlayTime'],
          location: eventData['location'],
          city: eventData['city'],
          userEmail: eventData['userEmail'],
          userId: eventData['userId'],
        );
        if (DateTime.parse(event.predictedPlayTime).isAfter(DateTime.now())) {
          fetchtedEventList.add(event);
        }
      });
      _events = fetchtedEventList;
    }).catchError((error) {
      return _events;
    });
  }

  void selectEvent(String eventId) {
    _selEventId = eventId;
    //notifyListeners();
  }
}
