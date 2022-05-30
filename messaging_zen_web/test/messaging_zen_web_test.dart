import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messaging_zen_web/messaging_zen_web.dart';

void main() {
  const MethodChannel channel = MethodChannel('messaging_zen_web');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MessagingZenWeb.platformVersion, '42');
  });
}
