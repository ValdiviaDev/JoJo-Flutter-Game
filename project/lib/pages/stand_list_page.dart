
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../P_PlayerSettings.dart';
import '../stand.dart';
import 'stand_page.dart';

class StandListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool gameSelection = ModalRoute.of(context).settings.arguments;
    final List<DocumentSnapshot> stands =
        PlayerSettingsLocalization.of(context).stands;
    int player = -1;
    if(gameSelection){
      bool allSelected = false;
      DocumentReference lobby = Firestore.instance.collection('lobbies').document(PlayerSettingsLocalization.of(context).lobbyID);
      lobby.get().then((snap){
        if(snap.data['P1'] == PlayerSettingsLocalization.of(context).name)
          player = 1;
        else
          player = 2;
      });
      lobby.snapshots().listen((snap){
        if(!allSelected && snap.data['P1Stand'] != -1 && snap.data['P2Stand'] != -1){
          allSelected = true;
          Navigator.of(context).pushReplacementNamed('/SG');
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Standpedia'),
      ),
      //Go to the stand page
      body: ListView.builder(
        itemCount: stands.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(stands[index].data["Stand name"],
                      style: TextStyle(
                          color: Colors.yellow[300],
                          fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(stands[index].data["Stand user"],
                          style: TextStyle(color: Colors.white)),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Story part: " + stands[index].data["Story part"],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () {
                    final stand = Stand.fromJson(stands[index].data);
                    if (!gameSelection) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => StandPage(stand),
                        ),
                      );
                    } else
                      preGameDialogOptions(context, stand, index, player);
                  },
                ),
                Divider(thickness: 2),
              ],
            ),
          );
        },
      ),
    );
  }

  Future preGameDialogOptions(BuildContext context, Stand stand, int standID, int player) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select stand?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Info",
                style: TextStyle(color: Colors.yellow[400]),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StandPage(stand),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text(
                "Select",
                style: TextStyle(color: Colors.green[400]),
              ),
              onPressed: () {
                Firestore.instance.collection('lobbies').document(PlayerSettingsLocalization.of(context).lobbyID).updateData(
                  {
                    (player == 1) ? 'P1Stand' : 'P2Stand' : standID,
                  }
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
