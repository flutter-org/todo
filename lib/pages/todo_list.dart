import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/utils/generate_todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late List<Todo> todoList;

  @override
  void initState() {
    super.initState();
    todoList = generateTodos(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('清单'),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return TodoItem(todo: todoList[index]);
          }),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: todo.isFinished ? 0.3 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 2,
              color: todo.priority.color,
            ),
          ),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      todo.isFinished ? 'assets/images/rect_selected.png' : 'assets/images/rect.png',
                      width: 25,
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(todo.title),
                    ),
                  ],
                ),
                Image.asset(
                  todo.isStar ? 'assets/images/star.png' : 'assets/images/star_normal.png',
                  width: 25,
                  height: 25,
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/group.png',
                  width: 25,
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(todo.timeString),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
