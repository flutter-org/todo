import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:todo/model/network_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group("NetworkClient", () {
    test('LoginOperation', () async {
      MockClient client = MockClient();
      when(client.post(
        any,
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      )).thenAnswer(
        (_) async => Response(
          '{"error":"","data":{"userId":"1"}}',
          200,
        ),
      );
      NetworkClient.instance().client = client;
      expect(await NetworkClient.instance().login('username', 'password'), '');
      // expect(await NetworkClient.instance().login('foo@qq.com', 'foobar'), '');
    });
    test('RegisterOperation', () async {});
  });
}
