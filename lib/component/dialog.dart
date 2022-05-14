import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String? text;

  const ProgressDialog({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
              height: 20,
            ),
            Text('请求中...'),
          ],
        ),
      ),
    );
  }
}

class SimpleAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const SimpleAlertDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
        content,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
