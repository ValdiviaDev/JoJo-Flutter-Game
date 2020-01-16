import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class WaitPlayer extends StatefulWidget {
  @override
  _WaitPlayerState createState() => _WaitPlayerState();
}

class _WaitPlayerState extends State<WaitPlayer> {
  DocumentReference ref;
  AsyncSnapshot lastSnapshot;
  bool closing;
  @override
  void didChangeDependencies() {
    ref = ModalRoute.of(context).settings.arguments;
    ref.snapshots().listen((snap) {
      if (snap.data['Running']) {
        closing = true;
        Navigator.of(context).pushReplacementNamed('/SG', arguments: ref);
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
            stream: ref.snapshots(),
            builder: (context, snapshot) {
              if (closing) {
                return Text('Returning');
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
                              ref.updateData({
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
        ref.updateData({
          'P1': lastSnapshot.data['P2'],
        });
      }
      ref.updateData({
        'P2': 'Empty',
        'Full': false,
      });
    }
    Navigator.of(context).pop(closing);
  }
}
