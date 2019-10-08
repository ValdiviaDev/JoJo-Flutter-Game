import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow, //Background colour
        appBar: AppBar(
          title: Text('Numbers'),
        ),
        body: Center(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NumberBall(1, Colors.red),
                NumberBall(2, Colors.green),
                NumberBall(3, Colors.blue),
                NumberBall(4, Colors.red),
                NumberBall(5, Colors.green),
                NumberBall(6, Colors.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberBall extends StatelessWidget {
  final int num;
  final Color color;

  NumberBall(@required this.num, 
             @required this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 50,
      height: 50,
      child: Center(
        child: Text('${this.num}',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      decoration: ShapeDecoration(
        color: color,
        shape: CircleBorder(),
      ),
    );
  }
}