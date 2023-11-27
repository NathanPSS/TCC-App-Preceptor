import 'package:flutter/material.dart';

import 'package:hujb_preceptor/widgets/login_form.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: TweenAnimationBuilder(
              child: LoginForm(),
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(opacity: value, child: child);
              },
            ),
          );
  }
}
