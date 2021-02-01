import 'package:Flaeckegosler/pages/Schnitzeljadg/models/place.dart';
import 'package:Flaeckegosler/pages/Schnitzeljadg/quizzMap.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/placeProvider.dart';

class DrinkQuizzPage extends StatefulWidget {
  @override
  _DrinkQuizzState createState() => _DrinkQuizzState();
}

class _DrinkQuizzState extends State<DrinkQuizzPage> {
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }

  String dropdownValue1 = 'One';
  String dropdownValue2 = 'One';
  String dropdownValue3 = 'One';
  String dropdownValue4 = 'One';

  checkSolution() {
    if (dropdownValue1 == 'One' &&
        dropdownValue2 == 'Twelve' &&
        dropdownValue3 == 'Seven' &&
        dropdownValue4 == 'Eight') {
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _allPlaces =
        Provider.of<PlaceProvider>(context, listen: false).allEvents;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Guess the Schnääps!"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  //color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "1.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue1,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                            decorationColor: Colors.black),
                        iconEnabledColor: Colors.white,
                        focusColor: Colors.yellow,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                            checkSolution();
                          });
                        },
                        items: <String>[
                          'One',
                          'Two',
                          'Free',
                          'Four',
                          'Five',
                          'Six',
                          'Seven',
                          'Eight',
                          'Nine',
                          'Ten',
                          'Eleven',
                          'Twelve'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  //color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "2.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                            decorationColor: Colors.black),
                        iconEnabledColor: Colors.white,
                        focusColor: Colors.yellow,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                            checkSolution();
                          });
                        },
                        items: <String>[
                          'One',
                          'Two',
                          'Free',
                          'Four',
                          'Five',
                          'Six',
                          'Seven',
                          'Eight',
                          'Nine',
                          'Ten',
                          'Eleven',
                          'Twelve'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  //color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "3.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue3,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                            decorationColor: Colors.black),
                        iconEnabledColor: Colors.white,
                        focusColor: Colors.yellow,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue3 = newValue;
                            checkSolution();
                          });
                        },
                        items: <String>[
                          'One',
                          'Two',
                          'Free',
                          'Four',
                          'Five',
                          'Six',
                          'Seven',
                          'Eight',
                          'Nine',
                          'Ten',
                          'Eleven',
                          'Twelve'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  //color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "4.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue4,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                            decorationColor: Colors.black),
                        iconEnabledColor: Colors.white,
                        focusColor: Colors.yellow,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue4 = newValue;
                            checkSolution();
                          });
                        },
                        items: <String>[
                          'One',
                          'Two',
                          'Free',
                          'Four',
                          'Five',
                          'Six',
                          'Seven',
                          'Eight',
                          'Nine',
                          'Ten',
                          'Eleven',
                          'Twelve'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Center(
                  child: _buildButton(_allPlaces),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(_allPlaces) {
    return new RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: new Text(_isButtonDisabled ? "... noch falsch!" : "Weiter!"),
      onPressed: () => {
        if (!_isButtonDisabled)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => QuizzMap(
                  initialLocation: PlaceLocation(
                      latitude: _allPlaces.elementAt(1).latitude,
                      longitude: _allPlaces.elementAt(1).longitude),
                  isSelecting: false,
                ),
              ),
            )
          }
      },
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  }
}
