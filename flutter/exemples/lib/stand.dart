class Stand {
  String standName, standUser, storyPart, description;
  String standType;

  String image;

  String power, speed, staying, precision, learning;
  int range;

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

final stoneFree = Stand(
  'Stone Free',
  'Jolyne Kujo',
  'Stone Ocean', //int?
  'Ability: Can form a body by gathering the strings '
   'together. Its maximum range is 2 meters, but when it '
   'unravels into a string, its range increases but becomes'
    'very weak. It can hear sounds from far away, like a'
    'telephone line.',
  'Short range', //int?
  'assets/stonefree.png',
  'A',
  'B',
  'A',
  'C',
  'A',
  2
);