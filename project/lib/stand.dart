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
