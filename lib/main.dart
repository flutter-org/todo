import 'package:flutter/material.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/route_url.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> routes = {
  LOGIN_PAGE_URL: (context) => const LoginPage(),
  REGISTER_PAGE_URL: (context) => const RegisterPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: routes[LOGIN_PAGE_URL]!(context),
      onGenerateRoute: (RouteSettings settings) {
        if ([REGISTER_PAGE_URL].contains(settings.name)) {
          return PageRouteBuilder(
            pageBuilder: (context, _, __) => routes[settings.name]!(context),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
    );
  }
}
