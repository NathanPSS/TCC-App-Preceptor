

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/config/brightness_mode.dart';

import '../config/colors.dart';
import '../providers/theme_mode.dart';



class SwitchMode extends ConsumerStatefulWidget{
  const SwitchMode({super.key});

 @override
  ConsumerState<ConsumerStatefulWidget> createState() {
   return _SwitchModeState();
  }
}

class _SwitchModeState extends ConsumerState<SwitchMode> with WidgetsBindingObserver{
  bool canClose = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      setBrightness(ref.watch(themeModeController).name);
    }
    }

   bool getSwitchValue(BuildContext ctx){
      var themeMode = ref.watch(themeModeController);
      if(themeMode == ThemeMode.system){
        var brightNess = MediaQuery.of(ctx).platformBrightness;
        if(brightNess == Brightness.dark){
          return true;
        }
        return false;
      }
      if(themeMode == ThemeMode.dark){
        return true;
      }
      return false;
    }

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.brightness_4);
      }
      return const Icon(Icons.brightness_6_outlined);
    },
  );
  final MaterialStateProperty<Color?> thumbColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.transparent;
      }
      return Colors.transparent;
    },
  );

  ThemeData theme(BuildContext ctx){
    var brightness = MediaQuery.of(ctx).platformBrightness;
    debugPrint(brightness.name);
    if(brightness == Brightness.dark){
      return kappDarkTheme;
    }
    return kappLightTheme.copyWith(
      colorScheme: kappLightTheme.colorScheme.copyWith(
      outline: Colors.yellow ,
      outlineVariant: Colors.yellow
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx,ref,child) {
     return Theme(
        data: getSwitchValue(context) ? kappDarkTheme : kappLightTheme.copyWith(
          colorScheme: kappLightTheme.colorScheme.copyWith(
            outline: Colors.yellow,
                outlineVariant: Colors.yellow
          )
        ),
        child: Switch(
          activeColor: Colors.black,
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.yellow,
          inactiveThumbColor: Colors.black,
          thumbIcon: thumbIcon,
          value: getSwitchValue(context),
          onChanged: (bool value) {

            setState(() {
              debugPrint(getSwitchValue(context).toString());
              ref.read(themeModeController.notifier).changeThemeMode(value);
            });
          },
        ),
      );
    });
     }
  }
/*
     return Switch(
           value: ref.read(themeModeController.notifier).getSwitchThemeModeValue(),
         onChanged: (bool value) {
             setState(() {
               debugPrint(stateSwitch.toString());
               ref.read(themeModeController.notifier).changeThemeMode();
             });
         },
       );
 */