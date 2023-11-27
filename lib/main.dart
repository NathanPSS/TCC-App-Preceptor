import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/api/token.dart';
import 'package:hujb_preceptor/config/brightness_mode.dart';
import 'package:hujb_preceptor/config/colors.dart';
import 'package:hujb_preceptor/global/dimensions_device.dart';
import 'package:hujb_preceptor/providers/theme_mode.dart';
import 'package:hujb_preceptor/screens/config.dart';
import 'package:hujb_preceptor/screens/home.dart';
import 'package:hujb_preceptor/screens/login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    ProviderScope(
      child: Consumer(
          builder: (ctx,ref,child) {
            return MaterialApp(
                darkTheme: kappDarkTheme,
                theme: kappLightTheme,
                themeMode: ref.watch(themeModeController),
                home: FutureBuilder(
                  future: hasValidToken(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.data!){
                        return  HomeScreen();
                      }
                      return const LoginScreen();
                    }
                    return const Scaffold(body: Center(child: CircularProgressIndicator()));
                  },
                )// HomeScreen() LoginScreen() CheckInScreen()
            );}
      ),
    ),
  );
}


