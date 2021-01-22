import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    accentColor: Colors.amber,

    // icons
    primaryIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.amber),
    accentIconTheme: IconThemeData(color: Colors.amber),

    //app bar
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          overline: TextStyle(color: Colors.black),
          caption: TextStyle(color: Colors.black),
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          headline4: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
          bodyText1: TextStyle(fontFamily: 'Hind', color: Colors.black),
          bodyText2: TextStyle(fontFamily: 'Hind', color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.amber)),
    accentColorBrightness: Brightness.light,

    //floating action button
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.amber),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(fontFamily: 'Hind', color: Colors.black),
      bodyText2: TextStyle(fontFamily: 'Hind', color: Colors.black),
    ),

    // text styling for headlines, titles, bodies of text, and more.
    accentTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(fontFamily: 'Hind', color: Colors.black),
      bodyText2: TextStyle(fontFamily: 'Hind', color: Colors.black),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(fontFamily: 'Hind', color: Colors.black),
      bodyText2: TextStyle(fontFamily: 'Hind', color: Colors.black),
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
      color: Colors.white,
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
