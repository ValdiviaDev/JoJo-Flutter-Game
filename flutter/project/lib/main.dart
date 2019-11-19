import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ChatListPage(),
    );
  }
}

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WhatsApp'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('groups').orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> groups = snapshot.data.documents;
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  groups[index].data['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(groups[index].documentID),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => NewGroupPage(),
          )).then((groupName) {
            db.collection('groups').document().setData({
              'name': groupName,
            });
          });
        },
      ),
    );
  }
}

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Group...')),
      body: Column(
        children: <Widget>[
          Text('Type the name of the new group:'),
          TextField(
            controller: _controller,
          ),
          RaisedButton(
            child: Text('Create Group'),
            onPressed: () {
              Navigator.of(context).pop(_controller.text);
            },
          )
        ],
      ),
    );
  }
}
