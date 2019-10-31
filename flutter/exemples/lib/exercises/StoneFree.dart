import 'package:flutter/material.dart';
import 'package:exemples/stand.dart';

void main() {
  runApp(StanpediaApp());
}

class StanpediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.indigo,
      ),
      home: StandPage(),
    );
  }
}

class StandPage extends StatelessWidget {
  const StandPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Standpedia'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 7, child: _Header()),
          Expanded(flex: 5, child: _Overview()),
          Expanded(flex: 4, child: _StandStats()),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              stoneFree.standName,
              style: TextStyle(
                fontSize: 25,
                color: Colors.yellow[300],
                fontWeight: FontWeight.bold,
              ),
            ),
            AspectRatio(
              aspectRatio: 2.03,
              child: Image.asset(
                stoneFree.image,
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
  const _Overview({
    Key key,
  }) : super(key: key);

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
                InfoTag(105, 25, stoneFree.storyPart, Icons.star_border),
                InfoTag(105, 25, stoneFree.standUser, Icons.face),
                InfoTag(105, 25, stoneFree.standType, Icons.aspect_ratio),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(stoneFree.description),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.indigo[200],
              size: 20,
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StandStats extends StatelessWidget {
  const _StandStats({
    Key key,
  }) : super(key: key);

  Row infoRectRow(InfoRect rect1, rect2, rect3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        rect1,
        rect2,
        rect3,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  infoRectRow(
                    InfoRect(Icons.whatshot, "Power", stoneFree.power),
                    InfoRect(Icons.shutter_speed, "Speed", stoneFree.speed),
                    InfoRect(Icons.directions_walk, "Range", stoneFree.range),
                  ),
                  Container(height: 30),
                  infoRectRow(
                    InfoRect(Icons.accessibility, "Staying", stoneFree.staying),
                    InfoRect(Icons.zoom_in, "Precision", stoneFree.precision),
                    InfoRect(
                        Icons.wb_incandescent, "Learning", stoneFree.learning),
                  ),
                ],
              ),
            ),
          ],
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