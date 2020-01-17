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
  String playerWinTri1;
  String playerWinTri2;
  int countStand1;
  int countStand2;
  String winner;

  bool closing;

  @override
  void initState() {
    closing = false;

    playerWinTri1 = "";
    playerWinTri2 = "";
    countStand1 = 0;
    countStand2 = 0;
    winner = "";

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
          "P1Rematch": false,
          "P2Rematch": false,
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
            //Calculate game outcome
            calculateGameOutcome();
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
                  child: _GameResults(playerWinTri1, playerWinTri2, countStand1,
                      countStand2, winner),
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
                          Navigator.of(context).pop(closeLobby);
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

  void calculateGameOutcome() {
    int triangle1P1 = 0;
    int triangle2P1 = 0;
    int triangle1P2 = 0;
    int triangle2P2 = 0;

//Player 1 triangle 1
    if (standP1.data['powerNum'] > standP1.data['precisionNum'] &&
        standP1.data['powerNum'] > standP1.data['rangeNum']) triangle1P1 = 1;
    if (standP1.data['precisionNum'] > standP1.data['powerNum'] &&
        standP1.data['precisionNum'] > standP1.data['rangeNum'])
      triangle1P1 = 2;
    if (standP1.data['rangeNum'] > standP1.data['powerNum'] &&
        standP1.data['rangeNum'] > standP1.data['precisionNum'])
      triangle1P1 = 3;

//Player 1 triangle 2
    if (standP1.data['learningNum'] > standP1.data['speedNum'] &&
        standP1.data['learningNum'] > standP1.data['stayingNum'])
      triangle2P1 = 1;
    if (standP1.data['speedNum'] > standP1.data['learningNum'] &&
        standP1.data['speedNum'] > standP1.data['stayingNum']) triangle2P1 = 2;
    if (standP1.data['stayingNum'] > standP1.data['speedNum'] &&
        standP1.data['stayingNum'] > standP1.data['learningNum'])
      triangle2P1 = 3;

//Player 2 triangle 1
    if (standP2.data['powerNum'] > standP2.data['precisionNum'] &&
        standP2.data['powerNum'] > standP2.data['rangeNum']) triangle1P2 = 1;
    if (standP2.data['precisionNum'] > standP2.data['powerNum'] &&
        standP2.data['precisionNum'] > standP2.data['rangeNum'])
      triangle1P2 = 2;
    if (standP2.data['rangeNum'] > standP2.data['powerNum'] &&
        standP2.data['rangeNum'] > standP2.data['precisionNum'])
      triangle1P2 = 3;

//Player 2 triangle 2
    if (standP2.data['learningNum'] > standP2.data['speedNum'] &&
        standP2.data['learningNum'] > standP2.data['stayingNum'])
      triangle2P2 = 1;
    if (standP2.data['speedNum'] > standP2.data['learningNum'] &&
        standP2.data['speedNum'] > standP2.data['stayingNum']) triangle2P2 = 2;
    if (standP2.data['stayingNum'] > standP2.data['speedNum'] &&
        standP2.data['stayingNum'] > standP2.data['learningNum'])
      triangle2P2 = 3;

//Calculate winner 1
    if (triangle1P1 == 1 && triangle1P2 == 2)
      playerWinTri1 = standP1.data['Stand name']; //Win 1
    else if (triangle1P1 == 1 && triangle1P2 == 3)
      playerWinTri1 = standP2.data['Stand name']; //Win 2
    else if (triangle1P1 == 2 && triangle1P2 == 3)
      playerWinTri1 = standP1.data['Stand name']; //Win 1
    else if (triangle1P1 == 2 && triangle1P2 == 1)
      playerWinTri1 = standP2.data['Stand name']; //Win 2
    else if (triangle1P1 == 3 && triangle1P2 == 1)
      playerWinTri1 = standP1.data['Stand name']; //Win 1
    else if (triangle1P1 == 3 && triangle1P2 == 2)
      playerWinTri1 = standP2.data['Stand name']; //Win 2

    if (playerWinTri1 == standP1.data['Stand name'])
      countStand1++;
    else if (playerWinTri1 == standP2.data['Stand name']) countStand2++;

//Calculate winner 2
    if (triangle2P1 == 1 && triangle2P2 == 2)
      playerWinTri2 = standP1.data['Stand name']; //Win 1
    else if (triangle2P1 == 1 && triangle2P2 == 3)
      playerWinTri2 = standP2.data['Stand name']; //Win 2
    else if (triangle2P1 == 2 && triangle2P2 == 3)
      playerWinTri2 = standP1.data['Stand name']; //Win 1
    else if (triangle2P1 == 2 && triangle2P2 == 1)
      playerWinTri2 = standP2.data['Stand name']; //Win 2
    else if (triangle2P1 == 3 && triangle2P2 == 1)
      playerWinTri2 = standP1.data['Stand name']; //Win 1
    else if (triangle2P1 == 3 && triangle2P2 == 2)
      playerWinTri2 = standP2.data['Stand name']; //Win 2

    if (playerWinTri2 == standP1.data['Stand name'])
      countStand1++;
    else if (playerWinTri2 == standP2.data['Stand name']) countStand2++;

    //Winner
    if (countStand1 > countStand2)
      winner = standP1.data['Stand name'];
    else if (countStand2 > countStand1)
      winner = standP2.data['Stand name'];
    else if (countStand1 == countStand2) winner = "draw";
  }
}

class _GameResults extends StatelessWidget {
  final String playerWinTri1;
  final String playerWinTri2;
  final int countStand1;
  final int countStand2;
  final String winner;
  const _GameResults(
    this.playerWinTri1,
    this.playerWinTri2,
    this.countStand1,
    this.countStand2,
    this.winner,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("The winner of the first triangle is a $playerWinTri1"),
        Text("The winner of the second triangle is a $playerWinTri2"),
        Center(
          child: Text(
            "$countStand1-$countStand2",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            (countStand1 != countStand2)?"$winner WINS" : "DRAW",
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
