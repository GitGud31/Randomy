import 'package:Randomy/controllers/routes_controller.dart';
import 'package:Randomy/controllers/theme_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//TODO: update APK
//TODO: update README
//TODO: add animation to dice, Rive?

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
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      themeMode: getTheme(theme),
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.amber).toTheme,
      theme: FlexColorScheme.light(scheme: FlexScheme.amber).toTheme,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }

  ThemeMode getTheme(String theme) {
    if (theme == 'Light') {
      return ThemeMode.light;
    } else if (theme == 'Dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
