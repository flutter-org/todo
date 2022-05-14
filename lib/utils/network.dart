import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

Future<bool> checkConnectivityResult(BuildContext context) async {
  ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('请求失败'),
        content: const Text('设备尚未连入网络'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
    return false;
  }
  return true;
}
