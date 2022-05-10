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
                color: Colors.white,
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    heightFactor: 0.4,
                    child: Image.asset('assets/images/mark.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
                      child: Column(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                      child: Container(
                        color: Colors.brown,
                        child: const Text('登录按钮'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                      child: Container(
                        color: Colors.brown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text('没有账号? '), Text('立即注册')],
                        ),
                      ),
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
