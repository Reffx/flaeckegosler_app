import 'package:flutter/material.dart';
import './snakeGame.dart';

class SecretCodePage extends StatelessWidget {
  var text = '';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("hello"),
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
                            if (value.toString() == 'kursiv!') {
                              Navigator.pushNamed(context, '/fettQuizz');
                            } else if (value.toString() == 'Snake!') {
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
