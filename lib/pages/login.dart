import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('top'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.brown,
                          child: const Text('邮箱'),
                        ),
                        Container(
                          color: Colors.brown,
                          child: const Text('密码'),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.brown,
                      child: const Text('登录按钮'),
                    ),
                    Container(
                      color: Colors.brown,
                      child: const Text('注册提示'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
