import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class SceneGame extends StatefulWidget {
  @override
  _SceneGameState createState() => _SceneGameState();
}

class _SceneGameState extends State<SceneGame> {
  DocumentReference lobbyRef;
  bool closing;

  @override
  void initState() {
    closing = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lobbyRef = Firestore.instance
        .collection('lobbies')
        .document(PlayerSettingsLocalization.of(context).lobbyID);
    lobbyRef.snapshots().listen((snap) {
      if (!snap.data["Running"] && !closing) {
        closing = true;
        lobbyRef.delete();
        Navigator.of(context).pop(false);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: lobbyRef.snapshots(),
          builder: (context, snapshot) {
            if (closing) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _PlayersAndStats(),
                ),
                Expanded(
                   flex: 1,
                  child: RaisedButton(
                    child: Text('End Game'),
                    onPressed: () {
                      closing = true;
                      lobbyRef.updateData({
                        'Running': false,
                      });
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PlayersAndStats extends StatelessWidget {
  const _PlayersAndStats({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
             Expanded(
              child: Image.asset(
                "assets/goldexperience.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Image.asset(
                "assets/killerqueen.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
             Expanded(
              child: Image.asset(
                "assets/goldexperiencestats.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Image.asset(
                "assets/killerqueenstats.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
