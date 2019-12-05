import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Standpedia pages/stand_list_page.dart';
import 'stand.dart';

void main() {
  runApp(StanpediaApp());
}

class StanpediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<FavouriteStands>(
      create: (_) => loadFavourites(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          canvasColor: Colors.indigo,
        ),
        home: StandListPage(),
      ),
    );
  }
}
