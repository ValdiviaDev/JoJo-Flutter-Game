import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Standpedia pages/stand_list_page.dart';

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