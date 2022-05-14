import 'package:flutter/material.dart';
import 'package:todo/component/image_hero.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/model/login_center.dart';
import 'package:todo/model/network_client.dart';
import 'package:todo/model/todo_list.dart';
import 'package:todo/res/assets_res.dart';

class AboutPage extends StatefulWidget {
  final TodoList todoList;
  final String userKey;

  const AboutPage({
    Key? key,
    required this.todoList,
    required this.userKey,
  }) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('关于'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  heightFactor: 0.3,
                  child: ImageHero.asset(AssetsRes.mark),
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
                      children: const [
                        Center(
                          child: Text(
                            'Funny Flutter Todo',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Center(
                          child: Text('版本 1.0.0'),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        WEB_VIEW_PAGE_URL,
                        arguments: WebViewArgument(
                          'https://flutter.cn/',
                          '隐私政策',
                        ),
                      );
                    },
                    child: const Text(
                      '隐私政策',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () async {
                        await NetworkClient.instance().uploadList(
                          widget.todoList.list,
                          widget.userKey,
                        );
                        await LoginCenter.instance().logout();
                        Navigator.of(context).pushReplacementNamed(LOGIN_PAGE_URL);
                      },
                      child: const Text(
                        '退出登录',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
