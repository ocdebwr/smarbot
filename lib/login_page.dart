// login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:smartbot/main.dart';
import 'package:smartbot/sign_up_page.dart';
import 'package:smartbot/user_provider.dart';
import 'package:smartbot/textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool signInRequired = false;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        // Retrieve user data from Firebase Realtime Database
        DatabaseReference userRef = _database.child('users').child(userId);
        final snapshot = await userRef.get();
        if (snapshot.value != null) {
          // Option 1: Cast to Map<String, dynamic> (if data structure is known)
          // Option 2: Access data using dynamic (if structure is flexible)
          dynamic userData = snapshot.value;
          if (userData is Map) {
            Provider.of<UserProvider>(context, listen: false)
                .setUsername(userData['username']);
          } else {
            print("Error: Unexpected data format in user data");
          }
        } else {
          print("Error: User data not found");
        }

        // Set user data in UserProvider

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FirstPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? "An unknown error occurred";
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
              'Login',
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
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'The email or password you entered is incorrect',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text(
                    'Login',
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
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  'Don''t have an account ? Sign Up',
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
//v1