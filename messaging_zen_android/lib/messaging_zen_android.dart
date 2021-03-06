import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

import 'method_call_handler.dart';

/// A named channel for communicating with platform plugins using asynchronous method calls.
const MethodChannel _channel = MethodChannel('plugins.flutter.io/messaging_zen_android');

/// An implementation of [MessagingZenPlatform] for Android
class MessagingZenAndroid extends MessagingZenPlatform {
  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith() {
    MessagingZenPlatform.instance = MessagingZenAndroid();
  }

  @override
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) async {
    assert(
      (androidChannelKey != null && androidChannelKey != ""),
      "messaging_zen_android implementation requires an androidChannelKey to initialize",
    );

    try {
      // Start observing channel messages (made from native code back to Flutter)
      _channel.setMethodCallHandler(methodCallHandler);

      // Call the native initialize function
      final bool result = await _channel.invokeMethod('initialize', {"key": androidChannelKey});

      return result;
    } catch (e) {
      debugPrint("Initialize call to android / kotlin platform failed.");
      rethrow;
    }
  }

  @override
  Future<bool> show() async {
    try {
      // Call the native Kotlin code
      final bool result = await _channel.invokeMethod('show');

      return result;
    } catch (e) {
      debugPrint("Initialize call to android / kotlin platform failed.");
      rethrow;
    }
  }
}
