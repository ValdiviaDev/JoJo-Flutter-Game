import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instructions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(flex: 3, child: Text("This is a two player game where each player has to choose a stand, and according to its attributes or stats, the winner will be one stand or another one.\nThe system how the winner is decided is by two like rock-paper-scissors triangles from the stats:\n\n* Power wins Precision, Precision wins Range and Range wins Power.\n* Speed wins Potential, Potential wins Durability and Durability wins Speed.\n\nFor every stand, the stat with the highest rank (A, B, C, D, E) in every triangle will be picked, and the stat in every triangle for both stands will be compared, and a victor will emerge for each triangle. In case of a draw in the game, a random stat will be picked and compared between the two and the highest stat will decide the victor.")),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/StatTriangle.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
