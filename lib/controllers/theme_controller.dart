import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, String>((ref) {
  final initialValue = ref.watch(themePersistProvider).savedTheme;

  return ThemeNotifier(ref, initialValue);
});

final themePersistProvider = Provider<ThemePersist>((_) => ThemePersist());

class ThemeNotifier extends StateNotifier<String> {
  ThemeNotifier(this.ref, String state) : super(state);

  final Ref ref;

  String get theme => state;

  set setTheme(String mode) {
    state = mode;
    ref.watch(themePersistProvider).saveTheme(mode);
  }
}

class ThemePersist {
  late final Box<String> themeBox;

  String get savedTheme => themeBox.values.first;

  Future<void> initTheme() async {
    await Hive.openBox<String>('theme').then((mode) => themeBox = mode);

    //first time loading
    if (themeBox.values.isEmpty) themeBox.add("System");
  }

  Future<void> saveTheme(String mode) async => await themeBox.put(0, mode);
}
