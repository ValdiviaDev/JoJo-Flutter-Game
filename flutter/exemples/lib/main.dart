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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(left: 30),),
              Text('bruh'),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('sound effect #2'),
              ),
              RaisedButton(child: Text('ROW ROW')),
              Container(width: 30, height: 120, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
