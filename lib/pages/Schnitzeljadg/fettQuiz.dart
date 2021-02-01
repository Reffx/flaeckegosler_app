import 'dart:math';
import 'dart:math' as math;

import 'package:Flaeckegosler/pages/Schnitzeljadg/models/place.dart';
import 'package:Flaeckegosler/pages/Schnitzeljadg/models/placeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quizzMap.dart';

class FettQuizzPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FettQuizzPageState();
}

class _FettQuizzPageState extends State<FettQuizzPage> {
  final _random = new Random();

  @override
  initState() {
    _rollDice();
    super.initState();
  }

  /**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
  int next(int min, int max) => min + _random.nextInt(max - min);

  var _1Row1Column;
  var _1Row2Column;
  var _1Row3Column;
  var _1Row4Column;
  var _2Row1Column;
  var _2Row2Column;
  var _2Row3Column;
  var _2Row4Column;
  var _3Row1Column;
  var _3Row2Column;
  var _3Row3Column;
  var _3Row4Column;
  var _4Row1Column;
  var _4Row2Column;
  var _4Row3Column;
  var _4Row4Column;

  _rollDice() {
    setState(() {
// random totally
      _1Row1Column = next(-15, 15);
      _1Row2Column = next(-15, 15);
      _1Row3Column = next(-15, 15);
      _2Row1Column = next(-15, 15);
      _2Row2Column = next(-15, 15);
      _2Row3Column = next(-15, 15);
      _3Row1Column = next(-15, 15);
      _3Row2Column = next(-15, 15);
      _3Row3Column = next(-15, 15);

      //4 Row
      _1Row4Column = -_1Row1Column - _1Row2Column - _1Row3Column + 9;
      _2Row4Column = -_2Row1Column - _2Row2Column - _2Row3Column + 1;
      _3Row4Column = -_3Row1Column - _3Row2Column - _3Row3Column + 0;
      //unterste Linie
      _4Row1Column = -_1Row1Column - _2Row1Column - _3Row1Column + 2;
      _4Row2Column = -_1Row2Column - _2Row2Column - _3Row2Column + 8;
      _4Row3Column = -_1Row3Column - _2Row3Column - _3Row3Column + 0;
      //Spezial
      _4Row4Column = _1Row1Column +
          _1Row2Column +
          _1Row3Column +
          _2Row1Column +
          _2Row2Column +
          _2Row3Column +
          _3Row1Column +
          _3Row2Column +
          _3Row3Column +
          -8;
    });
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  }

  var text = '';
  @override
  Widget build(BuildContext context) {
    var _latitude = Provider.of<PlaceProvider>(context, listen: false)
        .allEvents
        .elementAt(0)
        .latitude;
    var _longitude = Provider.of<PlaceProvider>(context, listen: false)
        .allEvents
        .elementAt(0)
        .longitude;
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("kursiv!"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: deviceSize.width * 0.60,
                    child: Form(
                      child: Column(children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(text),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Lösungswort!'),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {
                              text = '';
                              if (value.toString() == 'Diamantenwässerli') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (ctx) => QuizzMap(
                                      initialLocation: PlaceLocation(
                                          latitude: _latitude,
                                          longitude: _longitude),
                                      isSelecting: false,
                                    ),
                                  ),
                                );
                              } else {
                                text = "Leider nein!";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text(_1Row1Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_2Row1Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(_3Row1Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_4Row1Column.toString()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_1Row2Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.green,
                          child: Text(_2Row2Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_3Row2Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(_4Row2Column.toString()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text(_1Row3Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_2Row3Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(_3Row3Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_4Row3Column.toString()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_1Row4Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.green,
                          child: Text(_2Row4Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(_3Row4Column.toString()),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey,
                          child: Text(_4Row4Column.toString()),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(''),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(''),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(''),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: deviceSize.width / 2.55),
                  Text(
                    '•',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: deviceSize.width / 2.55),
                  Text(
                    '•',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Würfeln!'),
                onPressed: _rollDice,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
