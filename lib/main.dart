import 'package:chattah/auth_screen/email_login_signin.dart';
import 'package:chattah/auth_screen/email_login_signup.dart';
import 'package:chattah/auth_screen/FB_login_screen.dart';
import 'package:chattah/shared/loading.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Tah',
      theme: ThemeData(
          primaryColor: const Color(0xFFB2F7EF),
          primaryColorDark: const Color(0xFF010B41),
          primaryColorLight: const Color(0xFF7BDFF2),
          fontFamily: "RobotoMono",
          textTheme: const TextTheme(
              bodyText1: TextStyle(fontSize: 12, color: Color(0xFFEFF7F6)))),
      home: const SignInEmail(),
      debugShowCheckedModeBanner: false,
    );
  }
}
