import 'package:flutter/material.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/route_url.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LOGIN_PAGE_URL,
      routes: {
        LOGIN_PAGE_URL: (context) => const LoginPage(),
        REGISTER_PAGE_URL: (context) => const RegisterPage(),
      },
    );
  }
}
