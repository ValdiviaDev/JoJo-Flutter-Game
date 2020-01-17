import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class SceneGame extends StatefulWidget {
  @override
  _SceneGameState createState() => _SceneGameState();
}

class _SceneGameState extends State<SceneGame> {
  DocumentReference lobbyRef;
  DocumentSnapshot standP1;
  DocumentSnapshot standP2;

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
      if (snap.data["P1Rematch"] && snap.data["P2Rematch"]) {
        closing = true;
        lobbyRef.updateData({
          "P1Rematch"  : false,
          "P2Rematch" : false,
        });
        Navigator.of(context).pushReplacementNamed('/SLP', arguments: true);
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
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (closing) {
              return Center(child: CircularProgressIndicator());
            }
            standP1 = PlayerSettingsLocalization.of(context)
                .stands[snapshot.data["P1Stand"]];
            standP2 = PlayerSettingsLocalization.of(context)
                .stands[snapshot.data["P2Stand"]];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _PlayersPhotos(standP1, standP2),
                ),
                Expanded(
                  flex: 3,
                  child: _PlayerStatsPhotos(standP1, standP2),
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
                        child: Text('Exit to Lobby'),
                        onPressed: () {
                          closing = true;

                          bool closeLobby = (snapshot.data['P1'] == 'Empty' ||
                              snapshot.data['P2'] == 'Empty');
                          lobbyRef.updateData({
                            (snapshot.data['P1'] ==
                                    PlayerSettingsLocalization.of(context).name)
                                ? 'P1'
                                : 'P2': 'Empty',
                            'Running': closeLobby,
                          });
                          if(closeLobby) lobbyRef.delete();
                          Navigator.of(context).pop(false);
                        },
                      ),
                      RaisedButton(
                        child: Text('Rematch'),
                        onPressed: () {
                          lobbyRef.updateData({
                            (snapshot.data['P1'] ==
                                    PlayerSettingsLocalization.of(context).name)
                                ? 'P1Rematch'
                                : 'P2Rematch': true,
                          });
                          if (snapshot.data["P1Rematch"] ||
                              snapshot.data["P2Rematch"]) {
                            lobbyRef.updateData({
                              'P1Stand': -1,
                              'P2Stand': -1,
                            });
                          }
                        },
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
  final DocumentSnapshot standP1;
  final DocumentSnapshot standP2;

  const _PlayerStatsPhotos(
    this.standP1,
    this.standP2,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image.asset(
            standP1.data['img stats'],
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(
          child: Image.asset(
            standP2.data['img stats'],
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}

class _PlayersPhotos extends StatelessWidget {
  final DocumentSnapshot standP1;
  final DocumentSnapshot standP2;

  _PlayersPhotos(
    this.standP1,
    this.standP2,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image.asset(
            standP1.data['img'],
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(
          child: Image.asset(
            standP2.data['img'],
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
