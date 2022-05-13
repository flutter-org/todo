// ignore_for_file: constant_identifier_names

import 'package:todo/model/todo.dart';

enum OpenType {
  Add,
  Edit,
  Preview,
}

class RegisterPageArgument {
  final String className;
  final String url;

  RegisterPageArgument(this.className, this.url);
}

class EditTodoPageArgument {
  final OpenType openType;
  final Todo todo;

  EditTodoPageArgument(this.openType, this.todo);
}