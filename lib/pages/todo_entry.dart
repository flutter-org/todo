import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/colors.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/network_client.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/pages/about.dart';
import 'package:todo/pages/calendar.dart';
import 'package:todo/pages/reporter.dart';
import 'package:todo/pages/todo_list.dart';
import 'package:todo/res/assets_res.dart';

class TodoEntryPage extends StatefulWidget {
  const TodoEntryPage({Key? key}) : super(key: key);

  @override
  State<TodoEntryPage> createState() => _TodoEntryPageState();
}

class _TodoEntryPageState extends State<TodoEntryPage> with WidgetsBindingObserver {
  late int currentIndex;
  late List<Widget> pages;
  GlobalKey<TodoListPageState> todoListPageState = GlobalKey<TodoListPageState>();
  late TodoList _todoList;
  late String userKey;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TodoEntryArgument arguments = ModalRoute.of(context)?.settings.arguments as TodoEntryArgument;
    userKey = arguments.userKey;
    _todoList = TodoList(userKey);
    pages = [
      const TodoListPage(),
      const CalendarPage(),
      Container(),
      const ReporterPage(),
      const AboutPage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 应用进入后台时的回调
    if (state == AppLifecycleState.paused) {
      NetworkClient.instance().uploadList(_todoList.list, userKey);
    }
    // 应用进到前台时的回调
    if (state == AppLifecycleState.resumed) {
      _todoList.syncWithNetwork();
    }
    super.didChangeAppLifecycleState(state);
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
    return ChangeNotifierProvider<TodoList>.value(
      value: _todoList,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabChange,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(AssetsRes.lists),
            _buildBottomNavigationBarItem(AssetsRes.calendar),
            _buildBottomNavigationBarItem(
              AssetsRes.add,
              size: 50,
              singleImage: true,
            ),
            _buildBottomNavigationBarItem(AssetsRes.report),
            _buildBottomNavigationBarItem(AssetsRes.about),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
    );
  }
}
