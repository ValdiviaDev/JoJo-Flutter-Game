import 'package:flutter/material.dart';
import 'horari.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        //canvasColor: Colors.indigo,
      ),
      home: ConsultesPage(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcial'),
      ),
    );
  }
}

class ConsultesPage extends StatefulWidget {
  @override
  _ConsultesPageState createState() => _ConsultesPageState();
}

class _ConsultesPageState extends State<ConsultesPage> {
  List<Horari> horarisSelect = [];
  List<bool> auxCheckList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultes'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 70,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Horari escollit",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    //Save the new counter
                    child: Text('Canviar'),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (_) => EscullHorPage(auxCheckList),
                      ))
                          .then((isSelectH) {
                         if(isSelectH != null)   
                          auxCheckList = isSelectH;
                        setState(() {
                          horarisSelect.clear();
                          for (int i = 0; i < auxCheckList.length; ++i) {
                            if (auxCheckList[i] == true) {
                              horarisSelect.add(totsElsHoraris[i]);
                            }
                          }
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: horarisSelect.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(horarisSelect[index].toString()),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      horarisSelect.removeAt(index);
                    });
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

class EscullHorPage extends StatefulWidget {
  @override
  final List<bool> listChecks;
  EscullHorPage(this.listChecks);

  _EscullHorPageState createState() => _EscullHorPageState();
}

class _EscullHorPageState extends State<EscullHorPage> {
  List<bool> isHorariDisp;

  @override
  void initState() {
    if (widget.listChecks.isEmpty) {
      isHorariDisp = [
        for (int i = 0; i < totsElsHoraris.length; ++i) false,
      ];
    } else
      isHorariDisp = widget.listChecks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escull un horari...'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(isHorariDisp);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: totsElsHoraris.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                isHorariDisp[index] = !isHorariDisp[index];
              });
            },
            child: ListTile(
              leading: Checkbox(
                value: isHorariDisp[index],
                onChanged: (bool isChecked) {
                  setState(() {
                    isHorariDisp[index] = !isHorariDisp[index];
                  });
                },
              ),
              title: Text(totsElsHoraris[index].toString()),
            ),
          );
        },
      ),
    );
  }
}
