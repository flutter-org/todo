import 'package:flutter/material.dart';

class UserKeyInheritedWidget extends InheritedWidget {
  final String? userKey;

  const UserKeyInheritedWidget({
    Key? key,
    this.userKey,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(UserKeyInheritedWidget oldWidget) {
    return oldWidget.userKey == userKey;
  }

  static UserKeyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UserKeyInheritedWidget>();
}
