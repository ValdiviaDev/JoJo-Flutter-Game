import 'package:flutter/material.dart';

import '../stand.dart';

class StandPage extends StatefulWidget {
  final Stand stand;
  StandPage(this.stand);

  @override
  _StandPageState createState() => _StandPageState();
}

class _StandPageState extends State<StandPage> {
  bool isStandInList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stand')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 7, child: _Header(widget.stand)),
          Expanded(flex: 5, child: _Overview(widget.stand)),
          Expanded(flex: 5, child: _StandStats(widget.stand)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Stand stand;

  _Header(this.stand);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              stand.standName,
              style: TextStyle(
                fontSize: 25,
                color: Colors.yellow[300],
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Image.asset(
                stand.image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Stand stand;

  _Overview(this.stand);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle("Overview"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InfoTag(105, 30, stand.storyPart, Icons.star_border),
                InfoTag(105, 30, stand.standUser, Icons.face),
                InfoTag(105, 30, stand.standType, Icons.aspect_ratio),
              ],
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        child: Text(
                          stand.description,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Icon(
            Icons.remove,
            color: Colors.orange,
            size: 27,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class InfoTag extends StatelessWidget {
  final double w, h;
  final String label;
  final IconData icon;

  InfoTag(this.w, this.h, this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: w,
        height: h,
        decoration: ShapeDecoration(
          color: Colors.indigo[900],
          shape: StadiumBorder(),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(width: 5),
              Icon(
                icon,
                color: Colors.indigo[200],
                size: 20,
              ),
              Container(width: 5),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StandStats extends StatelessWidget {
  final Stand stand;

  _StandStats(this.stand);

  Row infoRectSpaced(InfoRect rect1) {
    return Row(
      children: <Widget>[rect1, Container(width: 20)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scrollbar(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      infoRectSpaced(
                          InfoRect(Icons.whatshot, "Power", stand.power)),
                      infoRectSpaced(
                          InfoRect(Icons.shutter_speed, "Speed", stand.speed)),
                      infoRectSpaced(InfoRect(
                          Icons.directions_walk, "Range", stand.range)),
                      infoRectSpaced(InfoRect(
                          Icons.accessibility, "Staying", stand.staying)),
                      infoRectSpaced(InfoRect(
                          Icons.zoom_in, "Precision", stand.precision)),
                      InfoRect(
                          Icons.wb_incandescent, "Learning", stand.learning),
                      Container(width: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRect extends StatelessWidget {
  final IconData icon;
  final String attribute;
  final String rank;

  InfoRect(this.icon, this.attribute, this.rank);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: Colors.indigo[200],
                size: 45,
              ),
            ),
            Text(
              attribute,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Center(
              child: Text(
                rank,
                style: TextStyle(fontSize: 28, color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
