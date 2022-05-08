import 'package:Randomy/screens/add_item.dart';
import 'package:Randomy/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:Randomy/controllers/theme_controller.dart';
import 'package:Randomy/main.dart';

ThemeMode _getTheme(String theme) {
  if (theme == 'Light') {
    return ThemeMode.light;
  } else if (theme == 'Dark') {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  const themeBuilderKey = 'theme button builder';
  final themePersist = ThemePersist();

  //To always start fresh.
  await themePersist.deleteDatabase();

  await themePersist.initTheme();

  //test case: check current theme mode
  testWidgets(
    '''Load persisted theme from database, 
  first time launch should default to ThemeMode.sytem''',
    (tester) async {
      late String capturedTheme;

      await tester.pumpWidget(
        ProviderScope(
            overrides: [
              themePersistProvider.overrideWithValue(themePersist),
            ],
            child: Consumer(
              builder: (_, ref, __) {
                final theme = ref.watch(themeProvider);
                capturedTheme = theme;

                return App();
              },
            )),
      );

      debugPrint(capturedTheme);

      /** 
       * Default route: HomeScreen 
       */
      expect(find.byType(HomeScreen), findsOneWidget);

      /**
      * First time launch, should get 'System' from ThemeNotifier, 
      * and [ThemeMode.system]to be applied.
      */
      //debugPrint(capturedTheme);
      expect(_getTheme(capturedTheme), equals(ThemeMode.system));
    },
  );

  //test case: Tap the PopupMenu button
  testWidgets(
    '''Tap PopupMenu button''',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
            overrides: [
              themePersistProvider.overrideWithValue(themePersist),
            ],
            child: MaterialApp(
              home: HomeScreen(),
            )),
      );

      /**
       * Expected to find the PopupMenu in the HomeScreen's AppBar
       */
      expect(find.byKey(Key(themeBuilderKey)), findsOneWidget);

      /**
       * Tap PopupMenu
       */
      await tester.tap(find.byKey(Key(themeBuilderKey)));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1)); //finish menu animation

      /**
      * expect to find: System, Light, Dark.
      */
      expect(find.text('System'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
    },
  );

  //test case: toggle to light mode
  testWidgets('''Toggle to light mode. ThemeNotifier's state should be 'Light',
   mode should be ThemeMode.light''', (tester) async {
    late String capturedTheme;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePersistProvider.overrideWithValue(themePersist),
        ],
        child: MaterialApp(
          home: Consumer(
            builder: ((_, ref, __) {
              final theme = ref.watch(themeProvider);
              capturedTheme = theme;

              return HomeScreen();
            }),
          ),
        ),
      ),
    );

    /**
     * Tap the 'Light' button
     */
    await tester.tap(find.byKey(Key(themeBuilderKey)));
    await tester.pump();
    await tester
        .pump(const Duration(seconds: 1)); //wait for animation to finish
    await tester.tap(find.text('Light'));
    await tester.pump();

    /**
      * Expect Light Theme Mode after tap
      */
    //debugPrint(capturedTheme);
    expect(_getTheme(capturedTheme), equals(ThemeMode.light));
  });

  //test case: toggle to dark mode
  testWidgets('''Toggle to dark mode. ThemeNotifier's state should be 'Dark',
   mode should be ThemeMode.dark''', (tester) async {
    late String capturedTheme;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePersistProvider.overrideWithValue(themePersist),
        ],
        child: MaterialApp(
          home: Consumer(
            builder: ((_, ref, __) {
              final theme = ref.watch(themeProvider);
              capturedTheme = theme;

              return HomeScreen();
            }),
          ),
        ),
      ),
    );

    /**
     * Tap the 'Dark' button
     */
    await tester.tap(find.byKey(Key(themeBuilderKey)));
    await tester.pump();
    await tester
        .pump(const Duration(seconds: 1)); //wait for animation to finish
    await tester.tap(find.text('Dark'));
    await tester.pump();

    /**
      * Expect Dark Theme Mode after tap
      */
    //debugPrint(capturedTheme);
    expect(_getTheme(capturedTheme), equals(ThemeMode.dark));
  });

  //test case: Navigate to AddItemScreen
  testWidgets('''Navigate to AddItemScreen''', (tester) async {
    const tooltipText = 'Add item';

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePersistProvider.overrideWithValue(themePersist),
        ],
        child: App(),
      ),
    );

    /**
     * Expect to find Add item FloatingActionButton
     */
    expect(find.byTooltip(tooltipText), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    //Tapping the button, should navigate to AddItemScreen
    await tester.tap(find.byTooltip(tooltipText));
    await tester.pump();
    await tester.pumpAndSettle();

    /**
     * Expects to be in AddItemScreen
     */
    expect(find.byType(AddItemScreen), findsOneWidget);
  });

  //TODO: test case: add item

  //TODO: test case: remove item

  //TODO: test case: empty items list
}
