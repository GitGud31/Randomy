import 'package:Randomy/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/app-theme.dart';

//TODO: update APK
//TODO: migrate to FlexColorScheme
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
      theme: AppTheme.lightTheme,
      home: MainScreen(),
    );
  }
}
