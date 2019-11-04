import 'package:flutter/material.dart';
import 'WordCounter.dart';

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
      home: CounterListPage(),
    );
  }
}

class CounterListPage extends StatefulWidget {
  const CounterListPage({
    Key key,
  }) : super(key: key);

  @override
  _CounterListPageState createState() => _CounterListPageState();
}

class _CounterListPageState extends State<CounterListPage> {
  List<WordCounter> wCount = [];

  void _maybeErase() {
    showDialog(
      context: context,
      builder: (innerContext) => AlertDialog(
            title: Text('Confirmation'),
            content: Text(
              'Are you sure you want to delete all the items?',
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(innerContext).pop();
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < wCount.length; ++i) wCount[i]..Reset();
                    Navigator.of(innerContext).pop();
                  });
                },
                child: Text('Erase'),
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter List'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _maybeErase();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => NewCounterPage(),
            ),
          )
              .then((enter) {
            if (enter != null) {
              WordCounter newCont = WordCounter(enter);
              wCount.add(newCont);
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: wCount.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: CountRect(wCount[index].word, wCount[index].numTimes),
              onTap: () {
                setState(() {
                  wCount[index].numTimes++;
                });
              },
              onLongPress: () {
                setState(() {
                  if (wCount[index].numTimes != 0) wCount[index].numTimes--;
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class NewCounterPage extends StatefulWidget {
  @override
  _NewCounterPageState createState() => _NewCounterPageState();
}

class _NewCounterPageState extends State<NewCounterPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: 'New name',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                controller: _controller,
                onSubmitted: (text) {
                  final String newName = text;
                  Navigator.of(context).pop(newName);
                },
              ),
              RaisedButton(
                //Save the new counter
                child: Text('Save'),
                onPressed: () {
                  final String newName = (_controller.text);
                  Navigator.of(context).pop(newName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountRect extends StatelessWidget {
  final String word;
  final int numTimes;

  CountRect(this.word, this.numTimes);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            //Num square
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                numTimes.toString(),
                style: TextStyle(fontSize: 70, color: Colors.black),
              ),
            ),
          ),
          Container(
            //Word rectangle
            width: 130,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                word,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
