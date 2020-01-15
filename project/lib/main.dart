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
import 'pages/scene_game.dart';

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
              //'/PGP': (context) => PreGamePage(),
              '/CuG': (context) => CurrentGames(),
              //'/CrG': (context) => CreateGame(),
              '/IP': (context) => InstructionsPage(),
              '/WP': (context) => WaitPlayer(),
              '/SG' : (context) => SceneGame(),
            },
          );
        },
      ),
    );
  }
}
