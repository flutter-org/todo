import 'package:flutter/material.dart';
import 'package:todo/model/todo_list.dart';

class ReporterPage extends StatefulWidget {
  final TodoList todoList;

  const ReporterPage({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  State<ReporterPage> createState() => _ReporterPageState();
}

class _ReporterPageState extends State<ReporterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('报告'),
      ),
      body: Center(
        child: Text(
          runtimeType.toString(),
        ),
      ),
    );
  }
}
