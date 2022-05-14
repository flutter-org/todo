import 'package:flutter/material.dart';
import 'package:todo/model/todo_list.dart';

class TodoListInheritedWidget extends InheritedWidget {
  final TodoList? todoList;

  const TodoListInheritedWidget({
    Key? key,
    this.todoList,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TodoListInheritedWidget oldWidget) {
    return oldWidget.todoList == todoList;
  }

  static TodoListInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TodoListInheritedWidget>();
}
