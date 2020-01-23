import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/news.dart';
import '../models/user.dart';
import '../models/auth.dart';
import '../models/event.dart';
import '../models/fasnacht_date.dart';

mixin ConnectedNewsModel on Model {
  List<Event> _events = [];
  String _selEventId;
  List<News> _news = [];
  String _selNewsId;
  User _authenticatedUser;
  bool _isLoading = false;
  List<FasnachtsDate> _fasnachtDate;
}

mixin EventModel on ConnectedNewsModel {
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
    _isLoading = true;
    notifyListeners();
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
        _isLoading = false;
        notifyListeners();
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
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEvent(
      String playTime, String predictedPlayTime, String location, String city) {
    _isLoading = true;
    notifyListeners();
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
      _isLoading = false;
      final Event updatedEvent = Event(
          id: selectedEvent.id,
          playTime: playTime,
          predictedPlayTime: predictedPlayTime,
          location: location,
          city: city,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _events[selectedEventIndex] = updatedEvent;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> fetchEvents() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-products-6da30.firebaseio.com/events.json')
        .then<Null>((http.Response response) {
      final List<Event> fetchtedEventList = [];
      final Map<String, dynamic> eventListData = json.decode(response.body);
      if (eventListData == null) {
        _isLoading = false;
        notifyListeners();
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
      _isLoading = false;
      notifyListeners();
      _selNewsId = null;
    }).catchError((error) {
      return _events;
    });
  }

  void selectEvent(String eventId) {
    _selEventId = eventId;
    notifyListeners();
  }
}

mixin NewsModel on ConnectedNewsModel {
  List<News> get allNews {
    return List.from(_news);
  }

  String get fasnachtDateStart {
    return _fasnachtDate.first.start;
  }

  String get fasnachtDateEnd {
    return _fasnachtDate.first.end;
  }

  int get selectedNewsIndex {
    return _news.indexWhere((News news) {
      return news.id == _selNewsId;
    });
  }

  String get selectedNewsId {
    return _selNewsId;
  }

  News get selectedNews {
    if (selectedNewsId == null) {
      return null;
    }
    return _news.firstWhere((News news) {
      return news.id == _selNewsId;
    });
  }

  Future<bool> fetchFasnacht() {
    return http
        .get('https://flutter-products-6da30.firebaseio.com/fasnachtDate.json')
        .then<Null>((http.Response response) {
      //  fetchedDataList.add(fasnachtData);
      final List<FasnachtsDate> fetchedFasnachtsDate = [];
      final Map<String, dynamic> dateListData = json.decode(response.body);

      dateListData.forEach((String dateId, dynamic dateData) {
        final FasnachtsDate date = FasnachtsDate(
            id: dateId.toString(),
            start: dateData['startDate'],
            end: dateData['endDate'],);
            fetchedFasnachtsDate.add(date);
           });
           _fasnachtDate = fetchedFasnachtsDate;
           return;
    }).catchError((error) {
      return;
    }); 
  }

  Future<bool> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flaeckegosler.ch/app/news-to-json/')
        .then<Null>((http.Response response) {
      final List<News> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic newsData) {
        final News news = News(
            id: productId.toString(),
            newsTitle: newsData['newsTitle'],
            imageURL: newsData['imageURL'],
            cropImageURL: newsData['cropImageURL'],
            timeCreatedUnix: newsData['timeCreatedUnix'],
            timeCreatedFormatted: newsData['timeCreatedFormatted'],
            newsCreatedBy: newsData['newsCreatedBy'],
            newsIntroText: newsData['newsIntroText'],
            newsMainText: newsData['newsMainText'],
            imageDescription: newsData['imageDescription']);
        fetchedProductList.add(news);
      });
      _news = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selNewsId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void selectNews(String newsId) {
    _selNewsId = newsId;
    notifyListeners();
  }
}

mixin UserModel on ConnectedNewsModel, Model {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC_GN37l3sU4be9dOuuqaOtWMe8GBHeoeQ',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC_GN37l3sU4be9dOuuqaOtWMe8GBHeoeQ',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Uuups, something went wrong!';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'EMAIL_NOT_FOUND';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'INVALID_PASSWORD';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  void logout() async {
    print('Logout');
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), () {
      logout();
    });
  }
}

mixin UtilityModel on ConnectedNewsModel {
  bool get isLoading {
    return _isLoading;
  }
}
