import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';

class HumidityPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('infor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Humidity',
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
                color: const Color(0xFFEB586b), // Set your desired background color
                borderRadius:
                    BorderRadius.circular(20), // Set your desired border radius
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Push the Column to the bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400, // Set the desired height
                    width: 600, // Set the desired width
                    child: Lottie.asset( 
                      'lib/assets/humid.json',// Adjust the fit as needed
                    ),
                  ),
                  const SizedBox(height: 40),
                  StreamBuilder(
                    stream: _database.child('doam').onValue,
                    builder: (context, snapshot) {
                    if   (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                    if (  !snapshot.hasData ||
                          snapshot.data!.snapshot.value == null) {
                      return const Text(
                          'No data available',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        );
                      }
                    var   humid =
                          snapshot.data!.snapshot.value.toString() + '%';
                    return Text(
                        humid,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                ),
                  const SizedBox(height: 138),
                ],
              ),
            ),
          ),
        ));
 
 }
}