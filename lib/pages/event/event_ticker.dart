import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authProvider.dart';
import '../../provider/eventProvider.dart';
import '../../widgets/news/event.dart';

class TickerPage extends StatefulWidget {
  final bool isNewLayout;
  TickerPage(this.isNewLayout);

  @override
  State<StatefulWidget> createState() {
    return _TickerStatePage();
  }
}

int _k = 5;

DecorationImage _buildBackgroundImage(bool isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/background_diadamas.png'),
    );
  }
}

Widget _buildTickerList(context, _isLoading) {
  var _eventProvider = Provider.of<EventProvider>(context, listen: false);
  Widget content;
  if (_isLoading) {
    content = Column(
      children: <Widget>[
        SizedBox(height: 50),
        CircularProgressIndicator(),
        SizedBox(height: 800)
      ],
    );
  }
  if (_eventProvider.allEvents.length > 0 && !_isLoading) {
    content = EventWidget();
  } else if (!_isLoading) {
    content = Center(
      child: Text(
        'Zur Zeit wird kein Live-Ticker geführt!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
  return content;
}

Widget _buildTitelTicker() {
  return Container(
    padding: EdgeInsets.only(top: 20, bottom: 20),
    child: Text(
      ' Chomm verbii! ',
      /* textAlign: TextAlign.start, */
      style: TextStyle(
        height: 1.2,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald',
        color: Colors.black,
        background: Paint()..color = Colors.white,
      ),
    ),
  );
}

class _TickerStatePage extends State<TickerPage> {
  var _isLoading = false;

  @override
  initState() {
    _fetchEvents();
    super.initState();
  }

  _fetchEvents() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<EventProvider>(context, listen: false).fetchEvents();
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<Null> test() async {
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            image: _buildBackgroundImage(widget.isNewLayout),
          ),
          child: RefreshIndicator(
            onRefresh: test,
            child: new CustomScrollView(slivers: <Widget>[
              SliverList(
                  delegate: new SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    _buildTitelTicker(),
                    _buildTickerList(context, _isLoading),
                    Container(
                      padding: EdgeInsets.only(bottom: 20, top: 20),
                      child: Center(
                        child: Consumer<AuthProvider>(
                          builder: (ctx, auth, _) => GestureDetector(
                            onTap: () {
                              _k = _k - 1;
                              print(_k);
                              if (_k == 0) {
                                auth.isAuth
                                    ? Navigator.pushNamed(context, '/userHome')
                                    : Navigator.pushNamed(context, '/auth');
                                _k = 5;
                              }
                            },
                            child: Text(
                              'Made with ♥ in Rothenburg',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oswald',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ])),
            ]),
          ),
        ),
      ),
    );
  }
}
