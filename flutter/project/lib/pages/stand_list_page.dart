import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stand.dart';
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => StandPage(stand),
                          ),
                        );
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
}
