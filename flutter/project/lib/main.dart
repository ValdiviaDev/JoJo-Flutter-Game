import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/create_game.dart';
import 'pages/current_games.dart';
import 'pages/instructions_page.dart';
import 'pages/main_screen.dart';
import 'pages/pre_game_page.dart';
import 'pages/stand_list_page.dart';
import 'pages/wait_player.dart';

import 'P_PlayerSettings.dart';

void main() => runApp(JoJoApp());

class JoJoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlayerSettings(),
        )
      ],
      child: Consumer<PlayerSettings>(
        builder: (context, pSettings, _) {
          return MaterialApp(
            supportedLocales: const [Locale('en')],
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              PlayerSettingsDelegate(pSettings.name),
            ],
            theme: ThemeData(
              brightness: Brightness.dark,
              canvasColor: Colors.indigo,
            ),
            routes: {
              '/': (context) => MainScreen(), //Main menu
              '/SLP': (context) => StandListPage(),
              '/PGP': (context) => PreGamePage(),
              '/CuG': (context) => CurrentGames(),
              '/CrG': (context) => CreateGame(),
              '/IP': (context) => InstructionsPage(),
            },
          );
        },
      ),
    );
  }
}

// Firebase TEST -----------------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ChatListPage(),
    );
  }
}

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WhatsApp'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('groups').orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> groups = snapshot.data.documents;
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  groups[index].data['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(groups[index].documentID),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (_) => NewGroupPage(),
          ))
              .then((groupName) {
            db.collection('groups').document().setData({
              'name': groupName,
            });
          });
        },
      ),
    );
  }
}

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Group...')),
      body: Column(
        children: <Widget>[
          Text('Type the name of the new group:'),
          TextField(
            controller: _controller,
          ),
          RaisedButton(
            child: Text('Create Group'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                Navigator.of(context).pop(_controller.text);
              }
            },
          )
        ],
      ),
    );
  }
}
