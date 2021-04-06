import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'models/highScore.dart';

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  List<HighScore> _highScoreData = [];
  var _userName = '';
  var _isLoading = false;
  var dropdownValue = 'Easy';

  final int squaresPerRow = 15;
  final int squaresPerCol = 25;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  var duration = Duration(milliseconds: 300);
  final randomGen = Random();
  Timer timer;

  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;

  void startGame() {
    //TODO: Ist hier weil bei Neustart die Duration sonst auf 300 war -> workaround, könnte optimiert werden
    if (dropdownValue == 'Easy') {
      duration = Duration(milliseconds: 300);
    } else if (dropdownValue == 'Medium') {
      duration = Duration(milliseconds: 250);
    } else if (dropdownValue == 'Hard') {
      duration = Duration(milliseconds: 150);
    } else if (dropdownValue == 'Extreme') {
      duration = Duration(milliseconds: 80);
    }

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

    createFood();

    isPlaying = true;
    updateTimer(duration);
  }

  updateTimer(durationUpdate) {
    timer = Timer.periodic(durationUpdate, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
    });
  }

  void createFood() {
    food = [randomGen.nextInt(squaresPerRow), randomGen.nextInt(squaresPerCol)];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squaresPerCol ||
        snake.first[0] < 0 ||
        snake.first[0] > squaresPerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  String getCongrats() {
    if (snake.length - 2 >= 60) {
      return 'Godlike!';
    } else if (snake.length - 2 >= 55) {
      return 'Mirakulös!';
    } else if (snake.length - 2 >= 50) {
      return 'Imponierend!';
    } else if (snake.length - 2 >= 45) {
      return 'Phänomenal!';
    } else if (snake.length - 2 >= 42) {
      return 'Atemberaubend!';
    } else if (snake.length - 2 >= 39) {
      return 'Überwältigend!';
    } else if (snake.length - 2 >= 36) {
      return 'Zauberhaft!';
    } else if (snake.length - 2 >= 33) {
      return 'Fabelhaft!';
    } else if (snake.length - 2 >= 30) {
      return 'Exzellent!';
    } else if (snake.length - 2 >= 27) {
      return 'Verblüffend!';
    } else if (snake.length - 2 >= 24) {
      return 'Beeindruckend!';
    } else if (snake.length - 2 >= 21) {
      return 'Ausgezeichnet!';
    } else if (snake.length - 2 >= 18) {
      return 'Hervorragend!';
    } else if (snake.length - 2 >= 15) {
      return 'Grossartig!';
    } else if (snake.length - 2 >= 12) {
      return 'Überdurchschnittlich!';
    } else if (snake.length - 2 >= 9) {
      return 'Bravo!';
    } else {
      return '';
    }
  }

  void endGame() {
    isPlaying = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Container(
            height: 120,
            child: Column(
              children: <Widget>[
                Text(
                  'Score: ${snake.length - 2}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(getCongrats()),
                TextFormField(
                  decoration: InputDecoration(hintText: "Name"),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    _userName = value.toString();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Send Score'),
              onPressed: () {
                if (_userName != '') {
                  addScore((snake.length - 2).toString(), _userName);
                }
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: AspectRatio(
                  aspectRatio: squaresPerRow / (squaresPerCol + 5),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: squaresPerRow,
                      ),
                      itemCount: squaresPerRow * squaresPerCol,
                      itemBuilder: (BuildContext context, int index) {
                        var color;
                        var x = index % squaresPerRow;
                        var y = (index / squaresPerRow).floor();

                        bool isSnakeBody = false;
                        for (var pos in snake) {
                          if (pos[0] == x && pos[1] == y) {
                            isSnakeBody = true;
                            break;
                          }
                        }

                        if (snake.first[0] == x && snake.first[1] == y) {
                          color = Colors.green;
                        } else if (isSnakeBody) {
                          color = Colors.green[200];
                        } else if (food[0] == x && food[1] == y) {
                          color = Colors.red;
                        } else {
                          color = Colors.grey[800];
                        }

                        return Container(
                          margin: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0),
                          ),
                        );
                      }),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: isPlaying ? Colors.red : Colors.blue,
                      child: Text(
                        isPlaying ? 'End' : 'Start',
                        style: fontStyle,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          isPlaying = false;
                        } else {
                          startGame();
                        }
                      },
                    ),
                    !isPlaying
                        ? FlatButton(
                            color: Colors.green,
                            child: Text(
                              isPlaying ? '' : 'Highscore',
                              style: fontStyle,
                            ),
                            onPressed: () {
                              fetchHighscore();
                              _showHighScoreDialog();
                            },
                          )
                        : Container(),
                    DropdownButton<String>(
                      icon: Icon(Icons.arrow_downward),
                      value: dropdownValue,
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
                          decorationColor: Colors.white),
                      iconEnabledColor: Colors.white,
                      focusColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue) {
                        if (newValue == 'Easy') {
                          if (isPlaying == true) {
                            timer.cancel();
                            updateTimer(Duration(milliseconds: 300));
                          } else {
                            duration = Duration(milliseconds: 300);
                          }
                          setState(() {
                            dropdownValue = 'Easy';
                          });
                        } else if (newValue == 'Medium') {
                          if (isPlaying == true) {
                            timer.cancel();
                            updateTimer(Duration(milliseconds: 225));
                          } else {
                            duration = Duration(milliseconds: 225);
                          }
                          setState(() {
                            dropdownValue = 'Medium';
                          });
                        } else if (newValue == 'Hard') {
                          if (isPlaying == true) {
                            timer.cancel();
                            updateTimer(Duration(milliseconds: 150));
                          } else {
                            duration = Duration(milliseconds: 150);
                          }
                          setState(() {
                            dropdownValue = 'Hard';
                          });
                        } else if (newValue == 'Extreme') {
                          if (isPlaying == true) {
                            timer.cancel();
                            updateTimer(Duration(milliseconds: 80));
                          } else {
                            duration = Duration(milliseconds: 80);
                          }
                          setState(() {
                            dropdownValue = 'Extreme';
                          });
                        }
                      },
                      items: <String>[
                        'Easy',
                        'Medium',
                        'Hard',
                        'Extreme',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Text(
                      'Score: ${snake.length - 2}',
                      style: fontStyle,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _showHighScoreDialog() {
    _highScoreData.sort((a, b) => b.score.compareTo(a.score));
    _isLoading
        ? Center(
            child: Container(
              padding: EdgeInsets.only(top: 000.0),
              child: CircularProgressIndicator(),
            ),
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              Widget scoreCards = GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: ListView(
                  children: [
                    Text(
                      'Score </> Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var tempScore = _highScoreData[index].score;
                        var tempName = _highScoreData[index].userName;
                        return Text(
                          '$tempScore $tempName',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        );
                      },
                      itemCount: _highScoreData.length,
                    ),
                  ],
                ),
              );
              return scoreCards;
            },
          );
  }

  void addScore(String score, String userName) {
    const url = 'https://flutter-products-6da30.firebaseio.com/snakeScore.json';
    http.post(
      url,
      body: json.encode({
        'score': score,
        'userName': userName,
      }),
    );
    /*final newProduct = HighScore(
      score: int.parse(score),
      userName: userName,
    );
    _highScoreData.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    // notifyListeners();*/
  }

  Future<bool> fetchHighscore() async {
    setState(() {
      _isLoading = true;
    });
    return http
        .get('https://flutter-products-6da30.firebaseio.com/snakeScore.json')
        .timeout(Duration(seconds: 6))
        .then<Null>((http.Response response) {
      final List<HighScore> fetchtedEventList = [];
      final Map<String, dynamic> eventListData = json.decode(response.body);
      if (eventListData == null) {
        return;
      }
      eventListData.forEach((String eventId, dynamic eventData) {
        final HighScore event = HighScore(
          score: int.parse(eventData['score']),
          userName: eventData['userName'],
        );
        fetchtedEventList.add(event);
      });
      _highScoreData = fetchtedEventList;
      setState(() {
        _isLoading = false;
        _showHighScoreDialog();
      });
    }).catchError((error) {
      return _highScoreData;
    });
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  }
}
