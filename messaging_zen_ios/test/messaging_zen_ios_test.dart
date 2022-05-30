import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messaging_zen_ios/messaging_zen_ios.dart';

void main() {
  const MethodChannel channel = MethodChannel('messaging_zen_ios');

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
    expect(await MessagingZenIos.platformVersion, '42');
  });
}
