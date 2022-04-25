import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final initialValue = ThemeMode.system;

  return ThemeNotifier(initialValue);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(state) : super(state);

  set setTheme(ThemeMode mode) => state = mode;

  ThemeMode get theme => state;
}
