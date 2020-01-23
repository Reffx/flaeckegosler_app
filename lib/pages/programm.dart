import 'package:flutter/material.dart';

DecorationImage _buildBackgroundImageDo() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_1.png'),
  );
}

DecorationImage _buildBackgroundImageFr() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_2.png'),
  );
}

DecorationImage _buildBackgroundImageSa() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_3.png'),
  );
}

DecorationImage _buildBackgroundImageSo() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_4.png'),
  );
}

DecorationImage _buildBackgroundImageMo() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_5.png'),
  );
}

DecorationImage _buildBackgroundImageDi() {
  return DecorationImage(
    fit: BoxFit.cover,
    colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
    image: AssetImage('assets/backgrounds/background_diadamas_3.png'),
  );
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
  Widget _buildDo() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageDo(),
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
                '(intern)',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '05.19',
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
                'Luzerner Umzug (Nr.29),',
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
                'Flecken',
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
        image: _buildBackgroundImageFr(),
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
                '13.15',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Ständli,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Rank', style: _buildProgrammTextStyle()),
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
                '15.15',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Ständli,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Coiffeur Muff',
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
        image: _buildBackgroundImageSa(),
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
                '12.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gosler meet Löchlitramper,',
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
                'Anschliessend',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Gässle,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Luzern', style: _buildProgrammTextStyle()),
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
                'Einzug Rüüdige Samschtig,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hofdere',
                style: _buildProgrammTextStyle(),
              ),
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
                'Auftritt Brauisaal 1,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hofdere',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '21.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Auftritt Sprötzehüslizelt,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hofdere',
                style: _buildProgrammTextStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '23.10',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Auftritt Monster,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Hofdere',
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
        image: _buildBackgroundImageSo(),
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
                '14.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Emmer Umzug (Nr. 9),',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Emmen', style: _buildProgrammTextStyle()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '15.40',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Auftritt Gersag,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Emmen',
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
                'Nachtessen Restaurant Panorama,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Emmen',
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
                'Raguball (23 Uhr),',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Rain',
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
        image: _buildBackgroundImageMo(),
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
                '10.00',
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
                '12.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Mittagessen Restaurant Hofgarten,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Luzern', style: _buildProgrammTextStyle()),
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
                'Luzerner Umzug (Nr. 29),',
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
                'Auftritt Schweizerhof,',
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
      ),
    );
  }

  Widget _buildDi() {
    return Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImageDi(),
      ),
      child: Column(
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
                'Kinderumzug,',
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
                '18.00',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Nachtessen Restaurant Ochsen,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text('Rothenburg', style: _buildProgrammTextStyle()),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '01.30',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 20),
              Text(
                'Schmette-Feete,',
                style: _buildProgrammTextStyle(),
              ),
              SizedBox(width: 10),
              Text(
                'Schmitte',
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
                padding: EdgeInsets.only(right: 10),
                child: Image.asset('assets/goslergrend.png',
                    fit: BoxFit.fitHeight),
              )
            ],
            bottom: TabBar(
              tabs: _kTabs,
            ),
          ),
          body: TabBarView(children: _kTabPages)),
    );
  }
}
