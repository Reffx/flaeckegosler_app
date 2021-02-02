import 'package:Flaeckegosler/pages/Schnitzeljadg/quizzMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './snakeGame.dart';
import 'models/place.dart';
import 'models/placeProvider.dart';

class SecretCodePage extends StatelessWidget {
  var text = '';
  @override
  Widget build(BuildContext context) {
    var _allPlaces =
        Provider.of<PlaceProvider>(context, listen: false).allEvents;
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Secret Area"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: deviceSize.width * 0.75,
                  child: Form(
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(text),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Secret Code!'),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            text = '';
                            if (value.toString() == 'kursiv') {
                              Navigator.pushNamed(context, '/fettQuizz'); //map1
                            } else if (value.toString() == 'Schnääps') {
                              Navigator.pushNamed(
                                  context, '/drinkQuizz'); //map2
                            } else if (value.toString() == 'kayCheat_2000') {
                              //Kay spiel, map 3
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(2).latitude,
                                        longitude:
                                            _allPlaces.elementAt(2).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() == 'Verblüffend!') {
                              //Snake highscore 25-29
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(3).latitude,
                                        longitude:
                                            _allPlaces.elementAt(3).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() == '2022_ExpeditioN') {
                              //map 5
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(4).latitude,
                                        longitude:
                                            _allPlaces.elementAt(4).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() == 'Raclette_Schlag') {
                              //map 6
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(5).latitude,
                                        longitude:
                                            _allPlaces.elementAt(5).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() ==
                                'Braui&Sible4wedding') {
                              //map 7
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(6).latitude,
                                        longitude:
                                            _allPlaces.elementAt(6).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() ==
                                'WageEschFertig2022') {
                              //map 8
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(7).latitude,
                                        longitude:
                                            _allPlaces.elementAt(7).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() ==
                                '_Bodechlapfhöchi2020!') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => QuizzMap(
                                    initialLocation: PlaceLocation(
                                        latitude:
                                            _allPlaces.elementAt(8).latitude,
                                        longitude:
                                            _allPlaces.elementAt(8).longitude),
                                    isSelecting: false,
                                  ),
                                ),
                              );
                            } else if (value.toString() == 'Snake') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) => SnakeGame(),
                                ),
                              );
                            } else {
                              text = "Leider nein!";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
