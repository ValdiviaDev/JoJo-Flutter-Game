import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow, //Background colour
        appBar: AppBar(
          title: Text('Numbers'),
        ),
        body: Center(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NutritionFact(
                    quantity: 247, description: 'Calories', units: 'kcal'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NutritionFact extends StatelessWidget {
  final int quantity;
  final String description;
  final String units;

  NutritionFact(
      {@required this.quantity,
      @required this.description,
      @required this.units});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 160,
      decoration:
          ShapeDecoration(shape: StadiumBorder(), color: Colors.orange[100]),
      child: Center(
        child: Text(
          '${this.quantity}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
