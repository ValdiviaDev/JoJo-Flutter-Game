import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';
import 'package:provider/provider.dart';

class CurrentGames extends StatefulWidget {
  @override
  _CurrentGamesState createState() => _CurrentGamesState();
}

class _CurrentGamesState extends State<CurrentGames> {
  CollectionReference lobbies;
  ScrollController _sCotroller;
  List<DocumentSnapshot> documents;
  var totalGames;
  @override
  void initState() {
    lobbies = Firestore.instance.collection("lobbies");
    _sCotroller = ScrollController();
    documents = null;
    totalGames =  0;
    lobbies.snapshots().listen((querysnap) {
      setState(() {
        documents = querysnap.documents;
        totalGames = documents.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a game | Total Games $totalGames'),
      ),
      body: ListView.separated(
        controller: _sCotroller,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: totalGames,
        itemBuilder: (context, i) {
          return InkWell(child: ListTile(title: Text('Game 1: ${documents[i].data["Name"]}')),
          onTap: (){
            DocumentReference lobby = Firestore.instance.collection("lobbies").document(documents[i].documentID);
            lobby.updateData({
              'P2': PlayerSettingsLocalization.of(context).name,
              'Full': true,
            });
            Navigator.of(context).pushNamed('/WP', arguments: lobby).then((close) {
                  if (close) lobby.delete();
                });
          },);
        },
      ),
    );
  }
}
