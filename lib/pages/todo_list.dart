import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/component/delete_todo_dialog.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/utils/generate_todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  late TodoList todoList;

  @override
  void initState() {
    super.initState();
    todoList = TodoList(generateTodos(100));
  }

  void addTodo(Todo todo) {
    todoList.add(todo);
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
            return TodoItem(
              todo: todoList.list[index],
              onFinished: (Todo todo) {
                setState(() {
                  todo.isFinished = !todo.isFinished!;
                  todoList.update(todo);
                });
              },
              onStar: (Todo todo) {
                setState(() {
                  todo.isStar = !todo.isStar!;
                });
              },
              onTap: (Todo todo) async {
                await Navigator.of(context).pushNamed(
                  EDIT_TODO_PAGE_URL,
                  arguments: EditTodoPageArgument(
                    openType: OpenType.Preview,
                    todo: todo,
                  ),
                );
                setState(() {
                  todoList.update(todo);
                });
              },
              onLongPress: (Todo todo) async {
                bool result = await showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteTodoDialog(
                        todo: todo,
                      );
                    });
                if (result) {
                  setState(() {
                    todoList.remove(todo.id!);
                  });
                }
              },
            );
          }),
    );
  }
}

typedef TodoEventCallback = Function(Todo todo);

class TodoItem extends StatelessWidget {
  final Todo todo;
  final TodoEventCallback? onStar;
  final TodoEventCallback? onFinished;
  final TodoEventCallback? onTap;
  final TodoEventCallback? onLongPress;

  const TodoItem({
    Key? key,
    required this.todo,
    this.onStar,
    this.onFinished,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: todo.isFinished! ? 0.3 : 1.0,
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
        child: GestureDetector(
          onTap: () {
            if (onTap != null) onTap!(todo);
          },
          onLongPress: () {
            if (onLongPress != null) onLongPress!(todo);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (onFinished != null) onFinished!(todo);
                        },
                        child: Image.asset(
                          todo.isFinished! ? 'assets/images/rect_selected.png' : 'assets/images/rect.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(todo.title ?? ''),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (onStar != null) onStar!(todo);
                    },
                    child: Image.asset(
                      todo.isStar! ? 'assets/images/star.png' : 'assets/images/star_normal.png',
                      width: 25,
                      height: 25,
                    ),
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
      ),
    );
  }
}
