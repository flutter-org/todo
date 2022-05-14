import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/component/delete_todo_dialog.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/res/assets_res.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  late TodoList todoList;
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    todoList = context.read<TodoList>();
    todoList.addListener(_updateTodoList);
  }

  void _updateTodoList() {
    TodoListChangeInfo changeInfo = todoList.value;
    if (changeInfo.type == TodoListChangeType.Update) {
      setState(() {});
    } else if (changeInfo.type == TodoListChangeType.Delete) {
      Todo todo = changeInfo.todoList[changeInfo.insertOrRemoveIndex];
      animatedListKey.currentState?.removeItem(changeInfo.insertOrRemoveIndex,
          (BuildContext context, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: TodoItem(todo: todo),
        );
      });
    } else if (changeInfo.type == TodoListChangeType.Insert) {
      animatedListKey.currentState?.insertItem(changeInfo.insertOrRemoveIndex);
    } else {
      // 编写逻辑
    }
  }

  @override
  void dispose() {
    todoList.removeListener(_updateTodoList);
    super.dispose();
  }

  void addTodo(Todo todo) {
    todoList.add(todo);
  }

  void removeTodo(Todo todo) async {
    bool result = await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteTodoDialog(
            todo: todo,
          );
        });
    if (result) {
      todoList.remove(todo.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('清单'),
      ),
      body: RefreshIndicator(
        onRefresh: () => todoList.syncWithNetwork(),
        child: AnimatedList(
            key: animatedListKey,
            initialItemCount: todoList.length,
            itemBuilder: (BuildContext context, int index, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: TodoItem(
                  todo: todoList.list[index],
                  onTap: (Todo todo) async {
                    await Navigator.of(context).pushNamed(
                      EDIT_TODO_PAGE_URL,
                      arguments: EditTodoPageArgument(
                        openType: OpenType.Preview,
                        todo: todo,
                      ),
                    );
                    todoList.update(todo);
                  },
                  onFinished: (Todo todo) {
                    todo.isFinished = !todo.isFinished!;
                    todoList.update(todo);
                  },
                  onStar: (Todo todo) {
                    todo.isStar = !todo.isStar!;
                    todoList.update(todo);
                  },
                  onLongPress: removeTodo,
                ),
              );
            }),
      ),
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
                          todo.isFinished! ? AssetsRes.rect_selected : AssetsRes.rect,
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
                      todo.isStar! ? AssetsRes.star : AssetsRes.star_normal,
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    AssetsRes.group,
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
