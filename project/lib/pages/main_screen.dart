import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../P_PlayerSettings.dart';
import 'stand_list_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.text = 'Player';
    //We will get the stand info only once, as we know stand info will never change
    Firestore.instance.collection("stands").getDocuments().then((query) {
      Provider.of<PlayerSettings>(context, listen: false).stands =
          query.documents;
    });
    super.initState();
  }

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
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
              ),
              RaisedButton(
                child: Text('Play'),
                onPressed: () {
                  Provider.of<PlayerSettings>(context, listen: false).name =
                      _textController.text;
                  Navigator.of(context).pushNamed('/CL');
                },
              ),
              RaisedButton(
                child: Text('Stand list'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SLP', arguments: false);
                },
              ),
              RaisedButton(
                child: Text('Instructions'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/IP');
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
