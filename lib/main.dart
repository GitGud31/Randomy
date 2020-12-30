import 'package:Randomy/main-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        appBarTheme: AppBarTheme(
            centerTitle: true, color: Colors.transparent, elevation: 0),
      ),
      home: MainScreen(),
    );
  }
}
