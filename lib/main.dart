import 'package:Randomy/views/main-screen.dart';
import 'package:Randomy/views/selection-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/utilities/app-theme.dart';

//TODO: migrate to Riverpod
//TODO: migrate to FlexColorScheme
//TODO: migrate to Hive

void main() async {
  //await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      home: MainScreen(),
      getPages: [
        GetPage(
          name: '/MainScreen',
          page: () => MainScreen(),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: '/SelectionPage',
          page: () => SelectionPage(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
