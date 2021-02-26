import 'package:flutter/material.dart';
import 'package:uber_rider/Screens/loginScreen.dart';
import 'package:uber_rider/Screens/mainscreen.dart';
import 'package:uber_rider/Screens/registeratiionScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: "Signatra",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisteratiionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
