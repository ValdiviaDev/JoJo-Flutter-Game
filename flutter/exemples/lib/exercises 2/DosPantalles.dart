import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RoutesApp());
}

class RoutesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrimeraPantalla(),
    );
  }
}

class PrimeraPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Primera Pantalla')),
      body: Center(
        child: RaisedButton(
          child: Text('Ves a la pantalla 2'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SegonaPantalla(),
            ));
          },
        ),
      ),
    );
  }
}

class SegonaPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segona Pantalla'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Tornar a la primera'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
