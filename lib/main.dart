import 'package:flutter/material.dart';
import 'package:todo/pages/about.dart';
import 'package:todo/pages/calendar.dart';
import 'package:todo/pages/edit_todo.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/reporter.dart';
import 'package:todo/pages/route_url.dart';
import 'package:todo/pages/todo_entry.dart';
import 'package:todo/pages/todo_list.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> routes = {
  ABOUT_PAGE_URL: (context) => const AboutPage(),
  CALENDAR_PAGE_URL: (context) => const CalendarPage(),
  EDIT_TODO_PAGE_URL: (context) => const EditTodoPage(),
  LOGIN_PAGE_URL: (context) => const LoginPage(),
  REGISTER_PAGE_URL: (context) => const RegisterPage(),
  REPORTER_PAGE_URL: (context) => const ReporterPage(),
  TODO_ENTRY_PAGE_URL: (context) => const TodoEntryPage(),
  TODO_LIST_PAGE_URL: (context) => const TodoListPage(),
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
      home: routes[TODO_ENTRY_PAGE_URL]!(context),
      onGenerateRoute: (RouteSettings settings) {
        if ([REGISTER_PAGE_URL, LOGIN_PAGE_URL].contains(settings.name)) {
          return PageRouteBuilder(
            pageBuilder: (context, _, __) => routes[settings.name]!(context),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              debugPrint('animation is $animation');
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
