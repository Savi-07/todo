// splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // print(screenWidth);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          height: (screenheight / 5.45),
          width: (screenWidth / 2.45),
          child: Image.asset(
            "asset/spalshScreen.png",
            fit: BoxFit.cover,
          ),
        ),
      )
          // Text(
          //   'ToDo app',
          //   style: TextStyle(
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          ),
    );
  }
}
