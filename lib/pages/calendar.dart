import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/extension/date_time.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_list.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late TodoList _todoList;
  late DateTime _initialDay;
  final Map<DateTime, List<Todo>> _date2TodoMap = {};
  final List<Todo> _todosToShow = [];

  @override
  void initState() {
    super.initState();
    _todoList = context.read<TodoList>();
    _initDate2TodoMap();
    _todoList.addListener(_updateData);
    _initialDay = DateTime.now().dayTime;
  }

  @override
  void dispose() {
    _todoList.removeListener(_updateData);
    super.dispose();
  }

  void _updateData() {
    setState(() {
      _todosToShow.clear();
      _date2TodoMap.clear();
      _initDate2TodoMap();
    });
  }

  void _initDate2TodoMap() {
    for (var todo in _todoList.list) {
      _date2TodoMap.putIfAbsent(todo.date!, () => []);
      _date2TodoMap[todo.date]!.add(todo);
    }
    _todosToShow.addAll(_date2TodoMap[_initialDay] ?? []);
  }

  void _onTap(Todo todo) async {
    Todo? changedTodo = await Navigator.of(context).pushNamed(
      EDIT_TODO_PAGE_URL,
      arguments: EditTodoPageArgument(
        openType: OpenType.Preview,
        todo: todo,
      ),
    );
    if (changedTodo == null) {
      return;
    }
    _todoList.update(todo);
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
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.transparent),
              todayTextStyle: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(child: _buildTaskListArea())
        ],
      ),
    );
  }

  Widget _buildTaskListArea() {
    return ListView.builder(
      itemCount: _todosToShow.length,
      itemBuilder: (context, index) {
        Todo todo = _todosToShow[index];
        return GestureDetector(
          onTap: () => _onTap(todo),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    color: todo.status.color,
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.all(10),
                  ),
                  Text(todo.title!),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.access_time,
                      size: 15,
                      color: Color(0xffb9b9bc),
                    ),
                    Text(
                      ' ${todo.startTime?.hour} - ${todo.endTime?.hour}',
                      style: const TextStyle(color: Color(0xffb9b9bc)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: const Color(0xffececed),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              )
            ],
          ),
        );
      },
    );
  }
}
