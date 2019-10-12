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
          Expanded(
            flex: 6,
            child: _Header(),
          ),
          Expanded(
            flex: 4,
            child: Container(color: Colors.blue),
          ),
          Expanded(
            flex: 3,
            child: Container(color: Colors.green),
          ),
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
    return Container(
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
            aspectRatio: 1,
            child: Image.asset(
              stoneFree.image,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
