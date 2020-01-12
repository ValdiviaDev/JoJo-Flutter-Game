import 'dart:io';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stand Mania')),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
              ),
              RaisedButton(
                child: Text('Play'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/PGP');
                },
              ),
              RaisedButton(
                child: Text('Stand list'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SLP');
                },
              ),
              RaisedButton(
                child: Text('Instructions'),
                onPressed: () {
                  //TODO
                },
              ),
              RaisedButton(
                child: Text('Exit'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        ));
  }
}
