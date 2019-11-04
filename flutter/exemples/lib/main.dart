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
      home: SongListPage(),
    );
  }
}

class SongListPage extends StatefulWidget {
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SongEditPage(),
          ));
        },
        tooltip: 'Add song',
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${index}'),
          );
        },
      ),
    );
  }
}

class SongEditPage extends StatefulWidget {
  @override
  _SongEditPageState createState() => _SongEditPageState();
}

class _SongEditPageState extends State<SongEditPage> {
  TextEditingController _titleController;
  TextEditingController _descController;
  TextEditingController _yearController;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: "Title",
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Description"),
              controller: _descController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Year"),
              controller: _yearController,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 120),
              child: RaisedButton(
                //Save the new counter
                child: Text('Save'),
                onPressed: () {
                  final String title = (_titleController.text);
                  final String desc = (_descController.text);
                  final String year = (_yearController.text);
                  Navigator.of(context).pop(title);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
