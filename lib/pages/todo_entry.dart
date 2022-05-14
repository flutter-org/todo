import 'package:flutter/material.dart';
import 'package:todo/config/colors.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/pages/about.dart';
import 'package:todo/pages/calendar.dart';
import 'package:todo/pages/reporter.dart';
import 'package:todo/pages/todo_list.dart';
import 'package:todo/utils/generate_todo.dart';

class TodoEntryPage extends StatefulWidget {
  const TodoEntryPage({Key? key}) : super(key: key);

  @override
  State<TodoEntryPage> createState() => _TodoEntryPageState();
}

class _TodoEntryPageState extends State<TodoEntryPage> {
  late int currentIndex;
  late List<Widget> pages;
  GlobalKey<TodoListPageState> todoListPageState = GlobalKey<TodoListPageState>();
  late TodoList todoList;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    todoList = TodoList(generateTodos(3));
    pages = [
      TodoListPage(key: todoListPageState, todoList: todoList),
      CalendarPage(todoList: todoList),
      Container(),
      ReporterPage(todoList: todoList),
      const AboutPage(),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String imagePath, {
    double? size,
    bool singleImage = false,
  }) {
    if (singleImage) {
      return BottomNavigationBarItem(
        icon: Image(
          width: size,
          height: size,
          image: AssetImage(imagePath),
        ),
        label: '',
      );
    }
    ImageIcon activeIcon = ImageIcon(
      AssetImage(imagePath),
      size: size,
      color: activeTabIconColor,
    );
    ImageIcon inactiveImageIcon = ImageIcon(
      AssetImage(imagePath),
      size: size,
      color: inactiveTabIconColor,
    );
    return BottomNavigationBarItem(
      icon: inactiveImageIcon,
      activeIcon: activeIcon,
      label: '',
    );
  }

  void _onTabChange(int index) async {
    if (index == 2) {
      Todo? todo = await Navigator.of(context).pushNamed<Todo>(
        EDIT_TODO_PAGE_URL,
        arguments: EditTodoPageArgument(
          openType: OpenType.Add,
        ),
      );
      if (todo != null) {
        index = 0;
        todoListPageState.currentState?.addTodo(todo);
      }
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabChange,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem('assets/images/lists.png'),
          _buildBottomNavigationBarItem('assets/images/calendar.png'),
          _buildBottomNavigationBarItem(
            'assets/images/add.png',
            size: 50,
            singleImage: true,
          ),
          _buildBottomNavigationBarItem('assets/images/report.png'),
          _buildBottomNavigationBarItem('assets/images/about.png'),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
