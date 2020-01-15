import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class WaitPlayer extends StatefulWidget {
  @override
  _WaitPlayerState createState() => _WaitPlayerState();
}

class _WaitPlayerState extends State<WaitPlayer> {
  DocumentReference ref;
  bool closing;
  @override
  void didChangeDependencies() {
    ref = ModalRoute.of(context).settings.arguments;
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
      appBar: AppBar(title: Text('Lobby')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (closing) {
              return Text('Returning');
            }
            return Column(
              children: <Widget>[
                Text("Lobby Game: ${snapshot.data['Name']}"),
                Text("Player 1: ${snapshot.data['P1']}"),
                Text("Player 2: ${snapshot.data['P2']}"),
                RaisedButton(
                  child: Text("Start"),
                  onPressed: () {
                    ref.updateData({
                      'Running': true,
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Exit"),
                  onPressed: () {
                    if (!snapshot.data['Full']) {
                      setState(() {
                        closing = true;
                      });
                    } else {
                      if (snapshot.data['P1'] ==
                          PlayerSettingsLocalization.of(context).name) {
                        ref.updateData({
                          'P1': snapshot.data['P2'],
                        });
                      }
                      ref.updateData({
                        'P2': 'Empty',
                        'Full': false,
                      });
                    }
                    Navigator.of(context).pop(closing);
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
