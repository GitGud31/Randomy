import 'package:Randomy/screens/home.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: update APK
//TODO: migrate to Hive
//TODO: migrate to GoRouter

void main() async {
  runApp(
    ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.amber).toTheme,
      theme: FlexColorScheme.light(scheme: FlexScheme.amber).toTheme,
      home: HomeScreen(),
    );
  }
}
