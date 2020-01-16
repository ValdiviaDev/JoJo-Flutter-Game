import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlayerSettings with ChangeNotifier {
  String _name = 'Player';
  String get name => _name;

  String _lobbyID = '';
  String get lobbyID => _lobbyID;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set lobbyID(String lobbyID) {
    _lobbyID = lobbyID;
    notifyListeners();
  }
}

class PlayerSettingsLocalization {
  static PlayerSettingsLocalization of(BuildContext context) {
    return Localizations.of<PlayerSettingsLocalization>(
        context, PlayerSettingsLocalization);
  }

  const PlayerSettingsLocalization(this._name, this._lobbyID);

  final String _name;
  final String _lobbyID;

  String get name => _name;
    String get lobbyID => _lobbyID;
}

class PlayerSettingsDelegate
    extends LocalizationsDelegate<PlayerSettingsLocalization> {
  const PlayerSettingsDelegate(this.name, this.lobbyID);

  final String name;
  final String lobbyID;

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<PlayerSettingsLocalization> load(Locale locale) {
    return SynchronousFuture(PlayerSettingsLocalization(name, lobbyID));
  }

  @override
  bool shouldReload(PlayerSettingsDelegate old){
    return (old.name != name || old.lobbyID != lobbyID);
  } 
}
