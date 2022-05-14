import 'package:flutter/material.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/login_center.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToLoginOrTodoEntry(BuildContext context) async {
    String? currentUserKey = await LoginCenter.instance().currentUserKey();
    if (currentUserKey == null || currentUserKey!.isEmpty) {
      Navigator.of(context).pushReplacementNamed(LOGIN_PAGE_URL);
    } else {
      Navigator.of(context).pushReplacementNamed(
        TODO_ENTRY_PAGE_URL,
        arguments: TodoEntryArgument(currentUserKey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _goToLoginOrTodoEntry(context);
    return Container();
  }
}
