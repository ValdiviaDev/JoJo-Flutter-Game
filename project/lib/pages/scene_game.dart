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
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: lobbyRef.snapshots(),
          builder: (context, snapshot) {
            if (closing) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _PlayersPhotos(),
                ),
                Expanded(
                  flex: 3,
                  child: _PlayerStatsPhotos(),
                ),
                Expanded(
                  flex: 3,
                  child: _GameResults(),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('End Game'),
                        onPressed: () {
                          closing = true;
                          lobbyRef.updateData({
                            'Running': false,
                          });
                          Navigator.of(context).pop(false);
                        },
                      ),
                      RaisedButton(
                        child: Text('Rematch (TODO)'),
                        onPressed: () {},
                      ),
                    ],
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

class _GameResults extends StatelessWidget {
  const _GameResults({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("The winner of the first triangle is a draw"),
        Text("The winner of the second triangle is a draw"),
        Text("The winner of the random stat pick is Gold Experience"),
        Center(
          child: Text(
            "1-0",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "Gold Experience WINS",
            style: TextStyle(
                fontSize: 25,
                color: Colors.yellow,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _PlayerStatsPhotos extends StatelessWidget {
  const _PlayerStatsPhotos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

class _PlayersPhotos extends StatelessWidget {
  const _PlayersPhotos({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
