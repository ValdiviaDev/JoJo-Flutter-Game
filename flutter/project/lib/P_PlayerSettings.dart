import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlayerSettings with ChangeNotifier {
  String _name = 'Player';
  String get name => _name;

  set name(String name) {
    _name = name;
    notifyListeners();
  }
}

class PlayerSettingsLocalization {
  static PlayerSettingsLocalization of(BuildContext context) {
    return Localizations.of<PlayerSettingsLocalization>(
        context, PlayerSettingsLocalization);
  }

  const PlayerSettingsLocalization(this._name);

  final String _name;

  String get name => _name;
}

class PlayerSettingsDelegate
    extends LocalizationsDelegate<PlayerSettingsLocalization> {
  const PlayerSettingsDelegate(this.name);

  final String name;

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<PlayerSettingsLocalization> load(Locale locale) {
    return SynchronousFuture(PlayerSettingsLocalization(name));
  }

  @override
  bool shouldReload(PlayerSettingsDelegate old) => old.name != name;
}