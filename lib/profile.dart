// lib/screens/Profile.dart

import 'package:flutter/material.dart';
import 'package:smartbot/login_page.dart';
import 'package:smartbot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  final String username;
  final String version;

  Profile({required this.username, required this.version});

  // Function to log out the user
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // After sign out, navigate back to the login screen or any other appropriate screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 88, 230, 235),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 128, 246, 250),
                  size: 150,
                ),
              ),
              SizedBox(height: 20),
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: Text(
                    'Version: $version',
                    style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to the Profile screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()),
                  );
                },
                icon: Icon(Icons.home),
                iconSize: 32,
                color: Colors.grey,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
                iconSize: 32,
                color: Colors.lightBlue[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
