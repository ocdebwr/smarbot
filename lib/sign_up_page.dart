import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:smartbot/login_page.dart';
import 'package:smartbot/textfield.dart';
import 'package:smartbot/user_provider.dart';
import 'main.dart'; // Ensure this import is correct based on your file structure

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool signUpRequired = false;
  bool obscurePassword = true;
IconData iconPassword = CupertinoIcons.eye_fill;

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Save user data to Firebase Realtime Database
        _database.child('users').child(userCredential.user!.uid).set({
          'email': _emailController.text,
          'username': _usernameController.text,
        });
        String userId = userCredential.user!.uid;

        // Retrieve user data from Firebase Realtime Database
        DatabaseReference userRef = _database.child('users').child(userId);
        final snapshot = await userRef.get();
        if (snapshot.value != null) {
          // Option 1: Cast to Map<String, dynamic> (if data structure is known)
          // Option 2: Access data using dynamic (if structure is flexible)
          dynamic userData = snapshot.value;
          if (userData is Map) {
            Provider.of<UserProvider>(context, listen: false).setUsername(userData['username']);
          } else {
            print("Error: Unexpected data format in user data");
          }
        } else {
          print("Error: User data not found");
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FirstPage()),
        );
      }
    } on FirebaseAuthException {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Text(
              'Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.grey[800]),
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_circle_fill),
                    validator: (val) {
                      return null;
                    }),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      return null;
                    }),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  validator: (val) {
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = CupertinoIcons.eye_fill;
                        } else {
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _signUp,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white,fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 88, 230, 235), // Set background color
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Already have an account ? Log In',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
