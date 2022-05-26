import 'dart:async';

import 'package:flutter/services.dart';
import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// A named channel for communicating with platform plugins using asynchronous method calls.
const MethodChannel _channel = MethodChannel('plugins.flutter.io/messaging_zen_android');

/// An implementation of [MessagingZenPlatform] for Android
class MessagingZenAndroid extends MessagingZenPlatform {
  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith() {
    MessagingZenPlatform.instance = MessagingZenAndroid();
  }

  @override
  Future<void> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  // @override
  // Future<bool> checkInitialized({String? webScriptId}) {
  //   // TODO: implement checkInitialized
  //   throw UnimplementedError();
  // }

  @override
  Future<void> show({String? webScriptId}) async {
    print("show() function called on federated messaging_zen_android plugin - DART CODE.");

    // Call the native Kotlin code
    final String? result = await _channel.invokeMethod('show');

    print("Returned result from Kotlin: $result");

    return;
  }
}
