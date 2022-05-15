import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/pages/login.dart';

void main() {
  testWidgets('login widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    Finder userInput = find.byType(TextField).first;
    Finder passwordInput = find.byType(TextField).last;
    Finder loginButton = find.byType(TextButton);

    await tester.enterText(userInput, 'foo@qq.com');
    await tester.enterText(passwordInput, 'foobar');
    await tester.tap(loginButton);

    expect(userInput, findsOneWidget);
    expect(passwordInput, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}
