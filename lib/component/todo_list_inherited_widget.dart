import 'package:flutter/material.dart';
import 'package:todo/model/todo_list_notifier.dart';

class TodoListInheritedWidget extends InheritedWidget {
  final TodoListNotifier? notifier;

  const TodoListInheritedWidget({
    Key? key,
    this.notifier,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TodoListInheritedWidget oldWidget) {
    return oldWidget.notifier == notifier;
  }

  static TodoListInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TodoListInheritedWidget>();
}
