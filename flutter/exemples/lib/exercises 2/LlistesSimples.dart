import 'package:flutter/material.dart';

void main() {
  runApp(LongListApp());
}

class SimpleListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Llistes'),
        ),
        body: ListView(
          children: <Widget>[
            for (int i = 0; i < 25; i++)
              ListTile(
                title: Text('El numero $i'),
                subtitle: Text('Un peazo número'),
                trailing: Icon(Icons.delete),
              ),
          ],
        ),
      ),
    );
  }
}

class LongListApp extends StatefulWidget {
  @override
  _LongListAppState createState() => _LongListAppState();
}

class _LongListAppState extends State<LongListApp> {
  List<int> numeros = [];

  @override
  void initState() {
    for (int i = 0; i < 10000; i++) {
      numeros.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: numeros.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item ${numeros[index]}'),
            );
          },
        )
      )
    );
  }
}
