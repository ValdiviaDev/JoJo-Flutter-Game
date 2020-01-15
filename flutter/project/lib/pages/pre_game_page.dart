import 'package:flutter/material.dart';
import 'package:project/P_PlayerSettings.dart';

class PreGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stand Mania')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Player Name: ${PlayerSettingsLocalization.of(context).name}"),
                  RaisedButton(
                    child: Text('Create game'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/CrG');
                    },
                  ),
                  RaisedButton(
                    child: Text('Join game'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/CuG');
                    },
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Go to main menu'),
                onPressed: () {
                  //TODO IF LAST PAGE IS NOT MAIN SCREEN WE CANNOT DO THIS
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }
}
