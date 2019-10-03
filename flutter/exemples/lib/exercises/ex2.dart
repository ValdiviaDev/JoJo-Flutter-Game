import 'package:flutter/material.dart';

void main() {
  //Semaphore
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Semaphore'),
        ),
        body: Center(
          child: Container(
            width: 160,
            height: 400,
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.rectangle),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Container(
                  alignment: Alignment.topLeft,
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}