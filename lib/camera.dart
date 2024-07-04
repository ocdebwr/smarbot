import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
