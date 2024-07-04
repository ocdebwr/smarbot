import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';

class TemperaturePage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('infor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 650,
          width: 350,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFF9E5AB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 2,
                  child: Lottie.asset(
                    'lib/assets/temp.json',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 150),
                StreamBuilder(
                  stream: _database.child('nhietdo').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData ||
                        snapshot.data!.snapshot.value == null) {
                      return Text(
                        'No data available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      );
                    }
                    var temperature =
                        snapshot.data!.snapshot.value.toString() + '°C';
                    return Text(
                      temperature,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                SizedBox(height: 138),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
