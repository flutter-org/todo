import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/pages/route_url.dart';

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
  final ImagePicker _picker = ImagePicker();
  File? image;

  late bool canRegister;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    canRegister = false;
  }

  void _checkInputValid(String _) {
    bool isInputValid = _emailController.text.contains('@') &&
        _passwordController.text.length >= 6 &&
        _passwordController.text == _repeatPasswordController.text;
    if (isInputValid == canRegister) {
      return;
    }
    setState(() {
      canRegister = isInputValid;
    });
  }

  void _gotoLogin() {
    Navigator.of(context).pushReplacementNamed(LOGIN_PAGE_URL);
  }

  void _getImage() async {
    final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile?.path != null) {
      setState(() {
        image = File(xFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      child: GestureDetector(
                        onTap: _getImage,
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          heightFactor: 0.4,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 48,
                                backgroundImage: (image == null
                                    ? const AssetImage(
                                        'assets/images/default_avatar.png',
                                      )
                                    : FileImage(image!)) as ImageProvider,
                              ),
                              Positioned(
                                right: 20,
                                top: 5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(17),
                                    ),
                                    color: Color.fromARGB(255, 80, 210, 194),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 34,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            bottom: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: '请输入邮箱',
                                  labelText: '邮箱',
                                ),
                                textInputAction: TextInputAction.next,
                                onSubmitted: (String value) {
                                  FocusScope.of(context).nextFocus();
                                },
                                onChanged: _checkInputValid,
                                controller: _emailController,
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: '请输入六位以上的密码',
                                  labelText: '密码',
                                ),
                                textInputAction: TextInputAction.next,
                                onSubmitted: (String value) {
                                  FocusScope.of(context).nextFocus();
                                },
                                obscureText: true,
                                onChanged: _checkInputValid,
                                controller: _passwordController,
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: '再次输入密码',
                                  labelText: '确认密码',
                                ),
                                obscureText: true,
                                onChanged: _checkInputValid,
                                controller: _repeatPasswordController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 12,
                            bottom: 12,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (!canRegister) return;
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return const Color.fromRGBO(69, 202, 160, 0.5);
                                }
                                return const Color.fromRGBO(69, 202, 181, 1);
                              }),
                            ),
                            child: const Text(
                              '注册并登录',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('已有账号？'),
                              InkWell(
                                onTap: _gotoLogin,
                                child: const Text('立即登录'),
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
