import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class SceneGame extends StatefulWidget {
  @override
  _SceneGameState createState() => _SceneGameState();
}

class _SceneGameState extends State<SceneGame> {
  DocumentReference ref;
  bool closing;

  @override
  void didChangeDependencies() {
    ref = ModalRoute.of(context).settings.arguments;
    ref.snapshots().listen((snap) {
      if (!snap.data["Running"] && !closing) {
        closing = true;
        ref.delete();
        Navigator.of(context).pop();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    closing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (closing) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('End Game'),
                  onPressed: () {
                    closing = true;
                    ref.updateData({
                      'Running': false,
                    });
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
