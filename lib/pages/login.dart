import 'package:flutter/material.dart';
import 'package:todo/component/dialog.dart';
import 'package:todo/component/fractionally_sized_transition.dart';
import 'package:todo/component/image_hero.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/login_center.dart';
import 'package:todo/model/network_client.dart';
import 'package:todo/res/assets_res.dart';
import 'package:todo/utils/network.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late bool canLogin;
  late bool useHero;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    canLogin = true;
    useHero = true;
    // _emailController.text = 'foo@qq.com';
    // _passwordController.text = 'foobar';
    // 3秒后再返回信息
    _emailController.text = 'lazy@qq.com';
    _passwordController.text = 'lazylazy';

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1000),
    );
    Animation<double> parentAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
    );
    Tween<double> tween = Tween<double>(begin: 0.4, end: 0.5);
    _animation = tween.animate(parentAnimation);
    _animationController.forward().then((value) => _animationController.reverse());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugDumpFocusTree();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  void _gotoRegister() {
    Navigator.of(context).pushReplacementNamed(
      REGISTER_PAGE_URL,
      arguments: RegisterPageArgument(
        'LoginPage',
        LOGIN_PAGE_URL,
      ),
    );
  }

  void _login() async {
    if (!canLogin) {
      return;
    }
    if (await checkConnectivityResult(context) == false) {
      return;
    }
    String email = _emailController.text;
    String password = _passwordController.text;
    showDialog(
      context: context,
      builder: (buildContext) => const ProgressDialog(text: '请求中'),
    );
    String result = await NetworkClient.instance().login(email, password);
    Navigator.of(context).pop();
    if (result.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => SimpleAlertDialog(
          title: '服务器返回信息',
          content: '登录失败,错误信息为: \n$result',
        ),
      );
      return;
    }
    setState(() {
      useHero = false;
    });
    String currentUserKey = await LoginCenter.instance().login(email);
    Navigator.of(context).pushReplacementNamed(
      TODO_ENTRY_PAGE_URL,
      arguments: TodoEntryArgument(currentUserKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    String markAssetName = AssetsRes.mark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            //利用MediaQuery来获取屏幕的高度
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: FractionallySizedTransition(
                        factor: _animation,
                        child: useHero ? ImageHero.asset(markAssetName) : Image.asset(markAssetName),
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
                            onPressed: canLogin ? _login : null,
                            child: const Text(
                              '登录',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('没有账号? '),
                              InkWell(
                                onTap: _gotoRegister,
                                child: const Text('立即注册'),
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
