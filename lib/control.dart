import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  void _sendCommand(int command) {
    _database.child('commands').push().set({'command': command});
  }

  @override
  Widget build(BuildContext context) {
    final double buttonSize = 100.0; // Adjust the size as needed

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wireless Control',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Colors.grey[800]  ,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Table(
          defaultColumnWidth: FixedColumnWidth(buttonSize),
          children: [
            TableRow(
              children: [
                SizedBox(), // Empty cell to position the "Up" button correctly
                AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => _sendCommand(1),
                    style: buttonStyle,
                    child: Icon(Icons.arrow_upward, color: Color.fromARGB(255, 88, 230, 235)),
                  ),
                ),
                SizedBox(), // Empty cell to balance the row
              ],
            ),
            TableRow(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => _sendCommand(4),
                    style: buttonStyle,
                    child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 88, 230, 235)),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => _sendCommand(0),
                    style: buttonStyle,
                    child: Icon(Icons.stop, color: Colors.red),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => _sendCommand(3),
                    style: buttonStyle,
                    child: Icon(Icons.arrow_forward, color: Color.fromARGB(255, 88, 230, 235)),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                SizedBox(), // Empty cell to position the "Down" button correctly
                AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => _sendCommand(2),
                    style: buttonStyle,
                    child: Icon(Icons.arrow_downward, color: Color.fromARGB(255, 88, 230, 235)),
                  ),
                ),
                SizedBox(), // Empty cell to balance the row
              ],
            ),
          ],
        ),
      ),
    );
  }
}
