import 'package:flutter/material.dart';
import 'package:todo/src/todo.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Todo",
          ),
        ),
        body: const Todo(),
      ),
    );
  }
}
