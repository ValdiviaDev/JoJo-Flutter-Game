import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RoutesApp());
}

class RoutesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MostraNumero(),
    );
  }
}

class MostraNumero extends StatefulWidget {
  @override
  _MostraNumeroState createState() => _MostraNumeroState();
}

class _MostraNumeroState extends State<MostraNumero> {
  int numero = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mostra Número')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$numero',
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
              child: Text('Editar'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EditaNumero(numero),
                  ),
                ).then((enter) {
                  if (enter != null) {
                    setState(() {
                      numero = enter;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditaNumero extends StatefulWidget {
  final int numero;
  EditaNumero(this.numero);

  @override
  _EditaNumeroState createState() => _EditaNumeroState();
}

class _EditaNumeroState extends State<EditaNumero> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: '${widget.numero}',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              onSubmitted: (text) {
                final int enter = int.parse(text);
                Navigator.of(context).pop(enter);
              },
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text('Guardar'),
              onPressed: () {
                final int enter = int.parse(_controller.text);
                Navigator.of(context).pop(enter);
              },
            )
          ],
        ),
      ),
    );
  }
}
