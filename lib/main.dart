import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/pages/about.dart';
import 'package:todo/pages/calendar.dart';
import 'package:todo/pages/edit_todo.dart';
import 'package:todo/pages/location_detail.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/reporter.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/pages/todo_entry.dart';
import 'package:todo/pages/todo_list.dart';
import 'package:todo/pages/webview.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> routes = {
  LOGIN_PAGE_URL: (context) => const LoginPage(),
  REGISTER_PAGE_URL: (context) => const RegisterPage(),
  TODO_ENTRY_PAGE_URL: (context) => const TodoEntryPage(),
  EDIT_TODO_PAGE_URL: (context) => const EditTodoPage(),
  LOCATION_DETAIL_PAGE_URL: (context) => const LocationDetailPage(),
  WEB_VIEW_PAGE_URL: (context) => const WebViewPage(),
  ABOUT_PAGE_URL: (context) => const AboutPage(),
  CALENDAR_PAGE_URL: (context) => const CalendarPage(),
  REPORTER_PAGE_URL: (context) => const ReporterPage(),
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
      home: routes[LOGIN_PAGE_URL]!(context),
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
        } else if ([EDIT_TODO_PAGE_URL].contains(settings.name)) {
          return CupertinoPageRoute<Todo>(
            builder: routes[settings.name]!,
            settings: settings,
            fullscreenDialog: true,
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
