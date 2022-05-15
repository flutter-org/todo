import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('todo App', () {
    FlutterDriver driver;
    // 运行前连接到 driver 应用
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    // 所有测试完成后,调用本回调,把 driver 应用关闭
    tearDownAll(() async {});

    test('login success', () async {
      driver = await FlutterDriver.connect();

      final userInput = find.byValueKey('user');
      final passwordInput = find.byValueKey('password');
      final loginButton = find.byValueKey('login');
      // 使用 traceAction 记录
      final timeline = await driver.traceAction(() async {
        await driver.tap(userInput);
        await driver.enterText('foo@qq.com');
        await driver.tap(passwordInput);
        await driver.enterText('foobar');
        await driver.tap(loginButton);
      });

      final summary = TimelineSummary.summarize(timeline);
      // 将性能数据保存到磁盘,可以使用 chrome://tracing 打开文件,进行性能分析
      summary.writeTimelineToFile('summary', pretty: true);
    });
  });
}
