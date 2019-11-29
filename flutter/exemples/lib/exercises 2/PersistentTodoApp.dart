import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: TodoListPage(),
    ),
  );
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class Todo {
  String what;
  bool done;
  Todo(this.what) : done = false;

  Todo.fromJson(Map<String, dynamic> json)
      : what = json['what'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'what': what,
        'done': done,
      };
}

/*

[
  { "what": "Aprendre Flutter", "done": true }, --> Map<String, dynamic>
  { "what": "Preparar Parcial", "done": false }, --> Map<String, dynamic>
] --> List

*/

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos; // Model

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future<void> _loadTodos() async {
    await Future.delayed(Duration(seconds: 5));
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/todo.json');
      String fileContents = await file.readAsString();
      List json = jsonDecode(fileContents);
      List<Todo> loaded = [];
      for (var elem in json) {
        loaded.add(Todo.fromJson(elem));
      }
      super.setState(() => _todos = loaded);
    } catch (e) {
      print("ERROR: No he pogut llegir els todos!");
      super.setState(() => _todos = []);
    }
  }

  Future<void> _writeTodos() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/todo.json');
    var json = jsonEncode(_todos);
    // print(json);
    await file.writeAsString(json);
  }

  @override
  void setState(fn) {
    super.setState(fn);
    _writeTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _maybeEraseChecked,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => NewTodoPage(),
            ),
          )
              .then((what) {
            setState(() {
              _todos.add(Todo(what));
            });
          });
        },
      ),
      body: (_todos == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _todos[index].done = !_todos[index].done;
                    });
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: _todos[index].done,
                      onChanged: (bool isChecked) {
                        setState(() {
                          _todos[index].done = isChecked;
                        });
                      },
                    ),
                    title: Text(
                      _todos[index].what,
                      style: TextStyle(
                        decoration: (_todos[index].done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                      ),
                    ),
                  ),
                );
              },
            )),
    );
  }

  void _maybeEraseChecked() {
    showDialog(
      context: context,
      builder: (innerContext) => AlertDialog(
        title: Text('Confirmation'),
        content: Text(
          'Are you sure you want to delete the checked items?',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(innerContext).pop(false);
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(innerContext).pop(true);
            },
            child: Text('Erase'),
          )
        ],
      ),
    ).then((erase) {
      if (erase) {
        _eraseChecked();
      }
    });
  }

  void _eraseChecked() {
    List<Todo> pending = [];
    for (var todo in _todos) {
      if (!todo.done) pending.add(todo);
    }
    setState(() {
      _todos = pending;
    });
  }
}

class NewTodoPage extends StatefulWidget {
  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Todo...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
            RaisedButton(
              child: Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
