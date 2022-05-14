import 'dart:convert';
import 'dart:html';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String preferenceKey = 'todo_app_login_key';

/// 单例对象
class LoginCenter {
  LoginCenter._();

  static final LoginCenter _instance = LoginCenter._();

  factory LoginCenter.instance() => _instance;

  late SharedPreferences _sharedPreferences;

  Future<void> _initSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<String?> currentUserKey() async {
    await _initSharedPreferences();
    if (_sharedPreferences.containsKey(preferenceKey)) {
      return _sharedPreferences.getString(preferenceKey);
    }
    return '';
  }

  Future<String> login(String email) async {
    await _initSharedPreferences();
    // 邮箱地址 明文存储 有安全风险,使用 crypto 将邮箱地址以 Hash 值形式存储
    String emailKey = sha256.convert(utf8.encode(email)).toString();
    await _sharedPreferences.setString(preferenceKey, emailKey);
    return emailKey;
  }

  Future<void> logout() async {
    await _initSharedPreferences();
    await _sharedPreferences.remove(preferenceKey);
  }
}
