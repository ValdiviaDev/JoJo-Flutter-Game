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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: 'Enter your name'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                heightFactor: 2.3,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  child: RaisedButton(
                    child: Text(
                      'Play',
                      style: new TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<PlayerSettings>(context, listen: false).name =
                          _textController.text;
                      Navigator.of(context).pushNamed('/CL');
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                heightFactor: 1.0,
                child: ButtonBarTheme(
                    data: ButtonBarThemeData(),
                    child: new ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            'Stand list',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/SLP', arguments: false);
                          },
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            'Instructions',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/IP');
                          },
                        ),
                      )
                    ])),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  widthFactor: 4.0,
                  heightFactor: 5.5,
                  child: RaisedButton(
                    child: Text('Exit'),
                    onPressed: () {
                      exit(0);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
