import 'package:Randomy/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
