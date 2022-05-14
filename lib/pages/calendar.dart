import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/extension/date_time.dart';
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
  late TodoList _todoList;
  late DateTime _initialDay;

  @override
  void initState() {
    super.initState();
    _todoList = widget.todoList;
    _initialDay = DateTime.now().dayTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('日历'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _initialDay,
            firstDay: DateTime(1900),
            lastDay: DateTime(2050),
          ),
        ],
      ),
    );
  }
}
