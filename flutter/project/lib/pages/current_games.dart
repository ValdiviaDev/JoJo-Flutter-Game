import 'package:flutter/material.dart';

class CurrentGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a game')),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          Column(
            children: <Widget>[
              ListTile(
                title: Text("todo"),
              ),
            ],
          );
        },
      ),
    );
  }
}
