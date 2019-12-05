import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Stand {
  String standName, standUser, storyPart, description;
  String standType;

  String image;

  String power, speed, staying, precision, learning, range;

  Stand(
      this.standName,
      this.standUser,
      this.storyPart,
      this.description,
      this.standType,
      this.image,
      this.power,
      this.speed,
      this.staying,
      this.precision,
      this.learning,
      this.range);

  Stand.fromJson(Map<String, dynamic> json)
      : standName = json['Stand name'],
        standUser = json['Stand user'],
        storyPart = json['Story part'],
        description = json['Description'],
        standType = json['Range'],
        image = json['img'],
        power = json['power'],
        speed = json['speed'],
        staying = json['staying'],
        precision = json['precision'],
        learning = json['learning'],
        range = json['range'];

    Map<String, dynamic> toJson() => {
        'Stand name': standName,
        'Stand user': standUser,
        'Story part': storyPart,
        'Description': description,
        'Range': standType,
        'img': image,
        'power': power,
        'speed': speed,
        'staying': staying,
        'precision': precision,
        'learning': learning,
        'range': range
      };
}

List<Stand> favStands = [];

class FavouriteStands {
  Set<String> _favs;
  FavouriteStands(this._favs);

  int get length => _favs.length;

  String getName(int index) => _favs.elementAt(index);

  bool isFavourite(String name) => _favs.contains(name);

  void addFavourite(String name) {
    _favs.add(name);
    // TODO: write JSON file with favourites
  }

  void removeFavourite(String name) {
    _favs.remove(name);
    // TODO: grabar
  }
}

Future<FavouriteStands> loadFavourites() async {
    await Future.delayed(Duration(seconds: 5));
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/favStands.json');
      String fileContents = await file.readAsString();
      List json = jsonDecode(fileContents);
      print("LOADED LIST OF STANDS");
      print(json);
      return FavouriteStands(Set<String>.from(json.cast<String>().toList()));
    } catch (e) {
      print("ERROR: Couldn't read the favourites list");
      return null;
    }
  }

  /*

  Future<void> _writeFavourites() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/favStands.json');
    var json = jsonEncode(favStands);

    await file.writeAsString(json);
    print("SAVED LIST OF STANDS");
    print(json);
  }

  */