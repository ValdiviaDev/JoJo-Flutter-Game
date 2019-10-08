import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, //Background colour
        appBar: AppBar(
          title: Text('Attributes'),
        ),
        body: Center(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ProductAttribute(
                    attrib: 'FOOD ENERGY',
                    quantity: 1250,
                    units: 'cal',
                    icon: Icon(
                      Icons.offline_bolt,
                      color: Colors.grey,
                    )),
                ProductAttribute(
                    attrib: 'SERVING SIZE',
                    quantity: 530,
                    units: 'g',
                    icon: Icon(
                      Icons.fastfood,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
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