import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
class AirQualityPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('infor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Air Quality',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: Colors.grey[800]),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            height: 650, // Set the desired height
            width: 350, // Set the width to fill the available space
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 88, 230, 235), // Set your desired background color
                borderRadius:
                    BorderRadius.circular(20), // Set your desired border radius
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Push the Column to the bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.scale(
                  scale: 2,
                  child: Lottie.asset(
                    'lib/assets/airquality.json',
                    fit: BoxFit.cover,
                  ),
                ),
                  SizedBox(height: 200),
                  StreamBuilder(
                    stream: _database.child('bui').onValue,
                    builder: (context, snapshot) {
                    if   (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                    if (  !snapshot.hasData ||
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
                    var   bui =
                          snapshot.data!.snapshot.value.toString() + '%';
                    return Text(
                        'Dust: '+bui,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                ),
                StreamBuilder(
                    stream: _database.child('gas').onValue,
                    builder: (context, snapshot) {
                    if   (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                    if (  !snapshot.hasData ||
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
                    var   gas =
                          snapshot.data!.snapshot.value.toString() + '%';
                    return Text(
                        'Gas: '+gas,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                ),
                  SizedBox(height: 66),
                ],
              ),
            ),
          ),
        ));
  }
}
