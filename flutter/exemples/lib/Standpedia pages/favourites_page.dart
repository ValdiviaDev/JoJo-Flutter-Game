import 'package:flutter/material.dart';
import '../stand.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite stands'),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < favStands.length; ++i)
            ListTile(
              title: Text(favStands[i].standName),
              subtitle: Text(favStands[i].standUser),
              trailing: Icon(Icons.star),
            ),
        ],
      ),
    );
  }
}
