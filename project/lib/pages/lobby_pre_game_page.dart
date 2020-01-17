import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

import 'stand_list_page.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  DocumentReference lobbyRef;
  AsyncSnapshot lastSnapshot;
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
      if (snap.data['Running'] && !closing) {
        closing = true;
        Navigator.of(context).pushReplacementNamed('/SLP', arguments: true);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _exit(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Lobby')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: lobbyRef.snapshots(),
              builder: (context, snapshot) {
                if (closing) {
                  return Center(child: CircularProgressIndicator());
                }
                lastSnapshot = snapshot;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Lobby Game: ${snapshot.data['Name']}",
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Player 1: ${snapshot.data['P1']}",
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Player 2: ${snapshot.data['P2']}",
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    (snapshot.data['P1'] ==
                            PlayerSettingsLocalization.of(context).name)
                        ? Align(
                          alignment: Alignment.center,
                          heightFactor: 1.5,
                          child: RaisedButton(
                            child: Text("Start"),
                            onPressed: () {
                              if (snapshot.data['P2'] != 'Empty') {
                                lobbyRef.updateData({
                                  'Running': true,
                                });
                              }
                            },
                          )
                        )
                        : Text("Waiting player 1 to Start"),
                    RaisedButton(
                      child: Text("Exit"),
                      onPressed: () {
                        _exit(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _exit(BuildContext context) {
    if (!lastSnapshot.data['Full']) {
      setState(() {
        closing = true;
      });
    } else {
      if (lastSnapshot.data['P1'] ==
          PlayerSettingsLocalization.of(context).name) {
        lobbyRef.updateData({
          'P1': lastSnapshot.data['P2'],
        });
      }
      lobbyRef.updateData({
        'P2': 'Empty',
        'Full': false,
      });
    }
    Navigator.of(context).pop(closing);
  }
}
