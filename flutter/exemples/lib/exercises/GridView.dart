import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: GridViewBuilderPage(),
    ),
  );
}

class GridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: Scrollbar(
        child: GridView.count(
          // scrollDirection: Axis.horizontal,
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(20),
          childAspectRatio: 2 / 3,
          children: <Widget>[
            for (int i = 0; i < 50; i++)
              Card(
                child: Center(
                  child: Text('$i'),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class GridViewBuilderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemCount: 1000,
          itemBuilder: (context, index) {
            print(index);
            return Card(
              child: Center(
                child: Text(
                  '${index + 1}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
