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

  final int squaresPerRow = 20;
  final int squaresPerCol = 40;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;

  void startGame() {
    const duration = Duration(milliseconds: 300);

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

    createFood();

    isPlaying = true;
    Timer.periodic(duration, (Timer timer) {
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

  void endGame() {
    isPlaying = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Text(
                  'Score: ${snake.length - 2}',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
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
      body: Column(
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
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
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
                      }),
                  FlatButton(
                      color: isPlaying ? Colors.black : Colors.green,
                      child: Text(
                        isPlaying ? '' : 'Highscore',
                        style: fontStyle,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                        } else {
                          fetchHighscore();
                          _showHighScoreDialog();
                        }
                      }),
                  Text(
                    'Score: ${snake.length - 2}',
                    style: fontStyle,
                  ),
                ],
              )),
        ],
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
}
