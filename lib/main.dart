import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartbot/button.dart';
import 'package:smartbot/feature.dart';
import 'package:smartbot/airqualitypage.dart';
import 'package:smartbot/Temperature.dart';
import 'package:smartbot/control.dart';
import 'package:smartbot/humidity.dart';
import 'package:smartbot/profile.dart'; 
import 'package:smartbot/camera.dart';
import 'package:smartbot/login_page.dart';
import 'package:smartbot/user_provider.dart'; // Import LoginPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Color.fromARGB(255, 62, 214, 146), // Set your primary color here
          secondary: Color.fromARGB(255, 88, 230, 235),
          onSecondary: Colors.white,
          onPrimary: Colors.black,
          outline: Color(0xFF424242)// Set your secondary color here
        ),
      ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(), // Start with LoginPage
      ),
    );
  }
}

// Other necessary imports and FirstPage widget
// ...

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late final userProvider = Provider.of<UserProvider>(context);
  String version = ''; //connected to github later
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                'SmartBot',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Color(0xFF3FD994),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Welcome, ' + userProvider.username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                  Text('Manage your bot with SmartBot',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 20),
                  GLButton(
                    text: "Bot - ESP32",
                    onTap: () {},
                  )
                ])
              ])),
          const SizedBox(height: 25),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Console",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 18))),
          SizedBox(height: 10),
          Row(children: [
            SizedBox(width: 25),
            FFeature(
                address: 'lib/icons/temperature-list.png',
                text: 'Temperature',
                ccolor: Color(0xFFF9E5AB),
                page: TemperaturePage()),
            SizedBox(width: 40),
            FFeature(
                address: 'lib/icons/humidity.png',
                text: 'Humidity',
                ccolor: Color(0xFFEB586b),
                page: HumidityPage()),
            SizedBox(width: 25),
          ]),
          SizedBox(height: 25),
          Row(children: [
            SizedBox(width: 25),
            FFeature(
                address: 'lib/icons/wind.png',
                text: 'Air Quality',
                ccolor: Color.fromARGB(255, 88, 230, 235),
                page: AirQualityPage()),
            SizedBox(width: 40),
            FFeature(
                address: 'lib/icons/sensor-on.png',
                text: 'Control',
                ccolor: Color.fromARGB(255, 255, 238, 81),
                page: ControlPage()),
            SizedBox(width: 25),
          ]),
          SizedBox(height: 25),
          Row(children: [
            SizedBox(width: 25),
            FFeature(
                address: 'lib/icons/photo-camera.png',
                text: 'Camera',
                ccolor: Color.fromARGB(255, 255, 163, 88),
                page: CameraPage()),
          ]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
                iconSize: 32,
                color: Colors.lightBlue[300]),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            username: userProvider.username,
                            version: version,
                          )),
                );
              },
              icon: Icon(Icons.person),
              iconSize: 32,
              color: Colors.grey,
            ),
          ]),
        ),
      ),
    );
  }
}