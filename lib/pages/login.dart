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
                child: const Center(
                  child: Text('bottom'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
