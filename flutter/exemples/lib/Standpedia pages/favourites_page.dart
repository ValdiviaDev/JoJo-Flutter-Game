import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stand.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favStands = Provider.of<FavouriteStands>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite stands'),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < favStands.length; ++i)
            ListTile(
              title: Text(favStands.getName(i)),
              // subtitle: Text(favStands.getName(i)), // TODO: nombre de personaje
              trailing: Icon(Icons.star),
            ),
        ],
      ),
    );
  }
}
