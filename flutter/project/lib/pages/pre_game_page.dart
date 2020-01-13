import 'package:flutter/material.dart';

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
                  RaisedButton(
                    child: Text('Create game'),
                    onPressed: () {
                      //TODO
                      Navigator.of(context).pushNamed('/CrG');
                    },
                  ),
                  RaisedButton(
                    child: Text('Join game'),
                    onPressed: () {
                      //TODO
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
