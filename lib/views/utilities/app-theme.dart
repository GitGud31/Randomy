import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.amber,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.amber),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
      headline6: TextStyle(
        color: Colors.black,
      ),
      headline1: TextStyle(
        color: Colors.black,
      ),
      headline2: TextStyle(
        color: Colors.black,
      ),
      headline3: TextStyle(
        color: Colors.black,
      ),
      headline4: TextStyle(
        color: Colors.black,
      ),
      headline5: TextStyle(
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        color: Colors.grey[900],
      ),
      subtitle2: TextStyle(
        color: Colors.grey[900],
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.grey[900],
      onPrimary: Colors.grey[900],
      primaryVariant: Colors.grey[900],
    ),
    cardTheme: CardTheme(
      color: Colors.grey[900],
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
      ),
      headline1: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.white,
      ),
      headline3: TextStyle(
        color: Colors.white,
      ),
      headline4: TextStyle(
        color: Colors.white,
      ),
      headline5: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.white70,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
      ),
    ),
  );
}
