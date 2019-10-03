import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basic Widgets'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            verticalDirection: VerticalDirection.down,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Band(2, '20%', Colors.pink),
              Band(3, '30%', Colors.purple),
              Band(5, '50%', Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class Band extends StatelessWidget {
  int flex;
  String text;
  Color color;

  Band(this.flex, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        color: color,
        child: Center(
          child: Text(text, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
