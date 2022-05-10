import 'package:Randomy/controllers/items_controller.dart';
import 'package:Randomy/models/item.dart';
import 'package:Randomy/screens/add_item.dart';
import 'package:Randomy/screens/home.dart';
import 'package:Randomy/widgets/item_tile.dart';
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

  //test case: fill both TextFields to add an Item to HomeScreen
  testWidgets('''Fill both TextFields to add an Item to HomeScreen''',
      (tester) async {
    const tooltipText = 'Add item';
    final itemKey = Key('Item textfield');
    final yournameKey = Key('Yourname textfield');

    await tester.pumpWidget(
      ProviderScope(overrides: [
        themePersistProvider.overrideWithValue(themePersist),
      ], child: App()),
    );

    //Navigate to AddItemScreen
    await tester.tap(find.byTooltip(tooltipText));
    await tester.pumpAndSettle();
    expect(find.byType(AddItemScreen), findsOneWidget);

    /** 
     * Expect to find two text fields
    */
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byKey(itemKey), findsOneWidget);
    expect(find.byKey(yournameKey), findsOneWidget);

    //fill the textfields
    await tester.enterText(find.byKey(itemKey), 'item 1');
    await tester.enterText(find.byKey(yournameKey), 'name 1');
    await tester.pump();

    expect(find.text('item 1'), findsOneWidget);
    expect(find.text('name 1'), findsOneWidget);

    //Tap the 'Add' button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    /**
     * Expect to be nagivate back to HomeScreen
     */
    expect(find.byType(AddItemScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);

    /** 
     * Expect to find one ItemTileBuilder in HomeScreen
     */
    expect(find.byType(ItemTileBuilder), findsOneWidget);
  });

  //test case: remove item
  testWidgets('''Dismisse Item to delete ''', (tester) async {
    //Add one Item manually
    final items = [Item(itemName: 'item 1', creatorName: 'name 1')];
    ItemsNotifier itemsNotifier = ItemsNotifier(items);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePersistProvider.overrideWithValue(themePersist),
          itemsProvider.overrideWithValue(itemsNotifier),
        ],
        child: App(),
      ),
    );

    await tester.pump();

    /** 
     * Expect to find one ItemTileBuilder in HomeScreen
     */
    expect(find.byType(ItemTileBuilder), findsOneWidget);
    expect(find.text('item 1'), findsOneWidget);
    expect(find.text('name 1'), findsOneWidget);

    //swipe right to left
    await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    /** 
     * Expect to find no text
    */
    expect(find.text('item 1'), findsNothing);
    expect(find.text('name 1'), findsNothing);
  });
}
