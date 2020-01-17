import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stand.dart';
import 'stand_page.dart';

class StandListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool gameSelection = ModalRoute.of(context).settings.arguments;
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
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(stands[index]["Stand name"],
                          style: TextStyle(
                              color: Colors.yellow[300],
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(stands[index]["Stand user"],
                              style: TextStyle(color: Colors.white)),
                          Container(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Story part: " + stands[index]["Story part"],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      onTap: () {
                        final stand = Stand.fromJson(stands[index]);
                        if (!gameSelection) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => StandPage(stand),
                            ),
                          );
                        } else
                          preGameDialogOptions(context, stand);
                      },
                    ),
                    Divider(thickness: 2),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future preGameDialogOptions(BuildContext context, Stand stand) {
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/SG');
              },
            ),
          ],
        );
      },
    );
  }
}
