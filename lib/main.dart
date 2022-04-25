import 'package:Randomy/controllers/theme_controller.dart';
import 'package:Randomy/screens/home.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//TODO: update APK
//TODO: add animation to dice, Rive?
//TODO: migrate to Hive
//TODO: migrate to GoRouter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final themePersist = ThemePersist();
  await themePersist.initTheme();

  runApp(
    ProviderScope(
      overrides: [
        themePersistProvider.overrideWithValue(themePersist),
      ],
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    late final mode;

    switch (theme) {
      case 'System':
        mode = ThemeMode.system;
        break;

      case 'Light':
        mode = ThemeMode.light;
        break;

      case 'Dark':
        mode = ThemeMode.dark;
        break;

      default:
        mode = ThemeMode.system;
    }

    return MaterialApp(
      themeMode: mode,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.amber).toTheme,
      theme: FlexColorScheme.light(scheme: FlexScheme.amber).toTheme,
      home: HomeScreen(),
    );
  }
}
