import 'package:flutter/material.dart';
import 'package:hujb_preceptor/config/storage.dart';



Future<void> setBrightness(String brightness) async{
  await storage.write(key: 'bTheme', value: brightness);
}

Future<ThemeMode> getThemeMode() async {
  var hasBrightness = await storage.containsKey(key: 'bTheme');
  if (hasBrightness) {
    var stringBrightness = await storage.read(key: 'bTheme');
    if (stringBrightness == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.dark;
  }
  return ThemeMode.system;
}