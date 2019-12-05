import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stand.dart';
import 'favourites_page.dart';
import 'stand_page.dart';

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
                  final stand = Stand.fromJson(stands[index]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StandPage(stand),
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