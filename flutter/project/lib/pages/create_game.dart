import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/P_PlayerSettings.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  TextEditingController _gameName;

  @override
  void initState() {
    _gameName = TextEditingController();
    _gameName.text = 'Game';
    super.initState();
  }

  Future<DocumentReference> createLobby() async {
    DocumentReference lobby =
        await Firestore.instance.collection("lobbies").add({
      'Name': _gameName.text,
      'P1': PlayerSettingsLocalization.of(context).name,
      'P2': 'Empty',
      'Full': false,
      'Running': false,
    });
    return lobby;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create game')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _gameName,
              decoration: InputDecoration(labelText: 'Game name'),
            ),
            RaisedButton(
              child: Text('Create'),
              onPressed: () async {
                DocumentReference lobby = await createLobby();
                Navigator.of(context)
                    .pushNamed('/WP', arguments: lobby)
                    .then((close) {
                  if (close) lobby.delete();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
