import 'package:flutter/material.dart';

class RegisterPageArgument {
  final String className;
  final String url;

  RegisterPageArgument(this.className, this.url);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final RegisterPageArgument argument = ModalRoute.of(context)?.settings.arguments as RegisterPageArgument;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text('注册页面,从${argument.className}-${argument.url}跳转而来'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
