import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/todo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreeeState();
  }
}

class _SplashScreeeState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay using Timer to navigate to the main screen after a certain duration
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const App()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to Todo!",
            ),
          ],
        ),
      ),
    );
  }
}
