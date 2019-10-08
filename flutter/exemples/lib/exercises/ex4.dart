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
          title: Text('Numbers'),
        ),
        body: Center(
          child: Container(
            color: Colors.yellow,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text('rock',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: StadiumBorder(),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text('jazz',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: StadiumBorder(),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Text('classical',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
