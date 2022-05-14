import 'package:flutter/material.dart';
import 'package:todo/model/todo_list.dart';

class CalendarPage extends StatefulWidget {
  final TodoList todoList;

  const CalendarPage({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日历'),
      ),
      body: Center(
        child: Text(
          runtimeType.toString(),
        ),
      ),
    );
  }
}
