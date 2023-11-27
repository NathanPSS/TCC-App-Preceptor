import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/config/brightness_mode.dart';

final futureThemeMode = FutureProvider<ThemeMode>((ref) async {
  return await getThemeMode();
});



final themeModeController = StateNotifierProvider<ThemeModeApp,ThemeMode>((ref) {
  final themeMode = ref.watch(futureThemeMode).when(
      data: (data) {
        return ThemeModeApp(data);
      }, error: (Object error, StackTrace stackTrace) {
    return ThemeModeApp(ThemeMode.system);
  }, loading: () {
    return ThemeModeApp(ThemeMode.system);
  },
  );
  return themeMode;
}
);

class ThemeModeApp extends StateNotifier<ThemeMode>{
  ThemeModeApp(super._state);

  void changeThemeMode(bool value) {
    if (value) {
      state = ThemeMode.dark;
      setBrightness('dark');
    } else {
     state = ThemeMode.light;
     setBrightness('light');
    }

  }
    bool getSwitchThemeModeValue(BuildContext ctx){
    var brightness = MediaQuery.of(ctx).platformBrightness;
      if(brightness == Brightness.dark) {
        return true;
      }
      return false;
    }
}