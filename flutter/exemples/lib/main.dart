import 'package:flutter/material.dart';
import 'Standpedia pages/stand_page.dart';
import 'stand.dart';

void main() {
  runApp(StanpediaApp());
}

class StanpediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.indigo,
      ),
      home: StandListPage(),
    );
  }
}

class StandListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Standpedia'),
      ),
      //Go to the stand page
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(crazyDiamond.standName),
            subtitle: Text(crazyDiamond.standUser),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StandPage(crazyDiamond),
                ),
              );
            },
          ),
          ListTile(
            title: Text(aerosmith.standName),
            subtitle: Text(aerosmith.standUser),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StandPage(aerosmith),
                ),
              );
            },
          ),
          ListTile(
            title: Text(stoneFree.standName),
            subtitle: Text(stoneFree.standUser),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StandPage(stoneFree),
                ),
              );
            },
          ),
        ],
      ),
      //Go to the favourite stand list page
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.star,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FavouritesPage(),
            ),
          );
        },
      ),
    );
  }
}

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
