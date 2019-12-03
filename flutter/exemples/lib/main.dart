import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: FutureBuilder(
        future: rootBundle.loadString('assets/stands.json'),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          String jsonString = snapshot.data;
          List stands = jsonDecode(jsonString);
          return ListView.builder(
            itemCount: stands.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(stands[index]["Stand name"]),
                subtitle: Text(stands[index]["Stand user"]),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StandPage(crazyDiamond),
                    ),
                  );
                },
              );
            },
          );
        },
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
