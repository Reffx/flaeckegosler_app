import 'package:flutter/material.dart';

DecorationImage _buildBackgroundImageDo(bool isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_1.png'),
    );
  }
}

DecorationImage _buildBackgroundImageFr(isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND_mirrored.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_2.png'),
    );
  }
}

DecorationImage _buildBackgroundImageSa(isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_3.png'),
    );
  }
}

DecorationImage _buildBackgroundImageSo(isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND_mirrored.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_4.png'),
    );
  }
}

DecorationImage _buildBackgroundImageMo(isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/MUSTER_REPETIEREND.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_5.png'),
    );
  }
}

DecorationImage _buildBackgroundImageDi(isNewLayout) {
  if (isNewLayout) {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
      image: AssetImage('assets/layout_2020/emptygrey.png'),
    );
  } else {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      image: AssetImage('assets/backgrounds/background_diadamas_3.png'),
    );
  }
}

TextStyle _buildProgrammTextStyle() {
  return TextStyle(
    height: 1.2,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Oswald',
    color: Colors.black,
    // background: Paint()..color = Colors.white,
  );
}

class ProgrammPage extends StatelessWidget {
  final bool isNewLayout;

  ProgrammPage(this.isNewLayout);

  Widget _buildDo() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageDo(isNewLayout),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'SchmuDo',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '04.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Tagwache,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                '(intern), BCH',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '05.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Tagwache mit Urknall,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Flecken', style: _buildProgrammTextStyle()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '06.45',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Fasnachtszmorge,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Pfarreiheim',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '09.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Fleckenkonzert,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Flecken',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '10.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Ständli Pistor,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Rothenburg',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Luzerner Umzug (Nr.15),',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Abend',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Monsterkonzert,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Gerbematt',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildFr() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageFr(isNewLayout),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fasnachts-Friitig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '11.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Schnebe-Frühstück,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                '(intern)',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Ständli,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Raiffeisenbank',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '16.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Ständli,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Landi',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Abend',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gönneranlass Fläckegosler,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Pfarreiheim',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildSa() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageSa(isNewLayout),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Flättere-Samschtig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Rothenburger Fasnacht,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Gerbematt',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Abend (23 Uhr)',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Raguball,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'MZH Rain',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildSo() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageSo(isNewLayout),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fasnachts-Sonntig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '10.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Fasnachtsgottesdienst,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Pfarrkirche',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '13.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Fasnacht Littau,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Dorfschulhaus Littau', style: _buildProgrammTextStyle()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '20.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Fasnacht Emmen,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Gersag',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildMo() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageMo(isNewLayout),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Güdis-Mäntig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '10.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gässle,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Luzerner Umzug (Nr. 15),',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '16.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gässle,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '18.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Freier Abend,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                '',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  Column _di(isNewLayout) {
    if (isNewLayout) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Güdis-Ziischtig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Umzug,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hochdorf',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Abend',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gässle,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/layout_2020/kopf_mythos.png'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Güdis-Ziischtig',
            style: TextStyle(
              height: 1.2,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
              color: Colors.black,
              //background: Paint()..color = Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Umzug,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hochdorf',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Abend',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gässle,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Luzern',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      );
    }
  }

  Widget _buildDi() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageDi(isNewLayout),
      ),
      child: _di(isNewLayout),
    );
  }

  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      _buildDo(),
      _buildFr(),
      _buildSa(),
      _buildSo(),
      _buildMo(),
      _buildDi(),
    ];
    final _kTabs = <Tab>[
      Tab(text: 'Do'),
      Tab(text: 'Fr'),
      Tab(text: 'Sa'),
      Tab(text: 'So'),
      Tab(text: 'Mo'),
      Tab(text: 'Di'),
    ];

    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '(Programm 2020)',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Image.asset('assets/goslergrend.png',
                    fit: BoxFit.fitHeight),
              ),
            ],
            bottom: TabBar(
              tabs: _kTabs,
            ),
          ),
          body: TabBarView(children: _kTabPages)),
    );
  }
}
