import 'package:flutter/material.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/route_url.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool canLogin;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    canLogin = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugDumpFocusTree();
    });
  }

  void _checkInputValid(String _) {
    bool isInputValid = _emailController.text.contains('@') && _passwordController.text.length >= 6;
    if (isInputValid == canLogin) {
      return;
    }
    setState(() {
      canLogin = isInputValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.4,
                        heightFactor: 0.4,
                        child: Image.asset('assets/images/mark.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: '请输入邮箱',
                                  labelText: '邮箱',
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: _checkInputValid,
                                controller: _emailController,
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: '请输入六位以上的密码',
                                  labelText: '密码',
                                ),
                                obscureText: true,
                                onChanged: _checkInputValid,
                                controller: _passwordController,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(69, 202, 181, 11)),
                            ),
                            child: const Text(
                              '登录',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (!canLogin) return;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('没有账号? '),
                              InkWell(
                                child: const Text('立即注册'),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    REGISTER_PAGE_URL,
                                    arguments: RegisterPageArgument(
                                      'LoginPage',
                                      LOGIN_PAGE_URL,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
