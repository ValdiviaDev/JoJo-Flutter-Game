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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: lobbyRef.snapshots(),
            builder: (context, snapshot) {
              if (closing) {
                return Center(child: CircularProgressIndicator());
              }
              lastSnapshot = snapshot;
              return Column(
                children: <Widget>[
                  Text("Lobby Game: ${snapshot.data['Name']}"),
                  Text("Player 1: ${snapshot.data['P1']}"),
                  Text("Player 2: ${snapshot.data['P2']}"),
                  (snapshot.data['P1'] ==
                          PlayerSettingsLocalization.of(context).name)
                      ? RaisedButton(
                          child: Text("Start"),
                          onPressed: () {
                            if (snapshot.data['P2'] != 'Empty') {
                              lobbyRef.updateData({
                                'Running': true,
                              });
                            }
                          },
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
