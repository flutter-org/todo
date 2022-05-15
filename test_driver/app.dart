import 'package:flutter_driver/driver_extension.dart';
import 'package:todo/main.dart' as todo;

void main() {
  // 启动集成插件
  enableFlutterDriverExtension();
  // 启动 todoList 应用
  todo.main();
}
