import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/theme_controller.dart';

class ThemeButtonBuilder extends ConsumerWidget {
  const ThemeButtonBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.brightness_6),
      initialValue: ref.watch(themeProvider),
      onSelected: (selected) =>
          ref.watch(themeProvider.notifier).setTheme = selected,
      itemBuilder: (_) => ["System", "Light", "Dark"].map((mode) {
        return PopupMenuItem<String>(value: mode, child: Text(mode));
      }).toList(),
    );
  }
}
