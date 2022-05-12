import 'package:flutter/material.dart';

class TodoEntryPage extends StatefulWidget {
  const TodoEntryPage({Key? key}) : super(key: key);

  @override
  State<TodoEntryPage> createState() => _TodoEntryPageState();
}

class _TodoEntryPageState extends State<TodoEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('入口'),
      ),
      body: Center(
        child: Text(
          runtimeType.toString(),
        ),
      ),
    );
  }
}
