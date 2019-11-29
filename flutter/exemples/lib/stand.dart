class Stand {
  String standName, standUser, storyPart, description;
  String standType;

  String image;

  String power, speed, staying, precision, learning , range;

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
    this.range
  );
}

final crazyDiamond = Stand(
  'Crazy Diamond',
  'Josuke Higashikata',
  'Diamond is Unbreakable',
  'Ability: Crazy Diamond can heal any wounds no matter how'
  ' serious they are, but it cannot heal its own user. '
  'It can also fix any broken object. If the person wounded '
  'is already dead, they won"t come back to life.',
  'Short range',
  'assets/crazydiamond.png',
  'A',
  'A',
  'B',
  'B',
  'C',
  "1-2 m"
);

final aerosmith = Stand(
  'Aerosmith',
  'Narancia Ghirga',
  'Vento Aureo',
  'Flies like a plane, and carries bullets and bombs. '
  'Tracks and detects humans and animals through their '
  'breath (carbon dioxide). Due to its low precision it '
  'cannot score hits without firing a massive barage.',
  'Long range',
  'assets/aerosmith.png',
  'B',
  'B',
  'C',
  'E',
  'C',
  "50 m"
);

final stoneFree = Stand(
  'Stone Free',
  'Jolyne Kujo',
  'Stone Ocean',
  'Ability: Can form a body by gathering the strings '
   'together. Its maximum range is 2 meters, but when it '
   'unravels into a string, its range increases but becomes '
    'very weak. It can hear sounds from far away, like a '
    'telephone line.',
  'Short range',
  'assets/stonefree.png',
  'A',
  'B',
  'A',
  'C',
  'A',
  "1-2 m"
);

List<Stand> favStands = [];