import 'package:Randomy/controllers/theme_controller.dart';
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

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      themeMode: theme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.amber).toTheme,
      theme: FlexColorScheme.light(scheme: FlexScheme.amber).toTheme,
      home: HomeScreen(),
    );
  }
}
