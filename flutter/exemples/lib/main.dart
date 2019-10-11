import 'package:flutter/material.dart';
import 'package:exemples/stand.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        backgroundColor: Colors.white, //Background colour
        appBar: AppBar(
          title: Text('Standpedia'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: AspectRatio(
                aspectRatio: 2/3,
                child: Image.asset(
                  stoneFree.image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(color: Colors.blue),
            ),
             Expanded(
              flex: 3,
              child: Container(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductAttribute extends StatelessWidget {
  final String attrib;
  final int quantity;
  final String units;
  final Icon icon;

  ProductAttribute({
    @required this.attrib,
    @required this.quantity,
    @required this.units,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        height: 70,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  attrib,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: icon,
                  ),
                  Container(
                    child: Text(
                      '$quantity' + ' $units',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }
}
