import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messaging_zen_ios/method_call_handler.dart';
import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// A named channel for communicating with platform plugins using asynchronous method calls.
const MethodChannel _channel = MethodChannel('plugins.flutter.io/messaging_zen_ios');

/// An implementation of [MessagingZenPlatform] for iOS
class MessagingZenIos extends MessagingZenPlatform {
  /// Registers this class as the default instance of [MessagingZenPlatform].
  static void registerWith() {
    MessagingZenPlatform.instance = MessagingZenIos();
  }

  @override
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) async {
    assert(
      (iosChannelKey != null && iosChannelKey != ""),
      "messaging_zen_ios implementation requires an iosChannelKey to initialize",
    );

    try {
      // Start observing channel messages (made from native code back to Flutter)
      _channel.setMethodCallHandler(methodCallHandler);

      // Call the native initialize function
      final bool result = await _channel.invokeMethod('initialize', {"key": iosChannelKey});

      return result;
    } catch (e) {
      debugPrint("Initialize call to ios / swift platform failed.");
      rethrow;
    }
  }

  @override
  Future<bool> show() async {
    try {
      // Call the native Swift code
      final bool result = await _channel.invokeMethod('show');

      return result;
    } catch (e) {
      debugPrint("show call to ios / swift platform failed.");
      rethrow;
    }
  }

  // @override
  // Future<bool> invalidate() async {
  //   try {
  //     // Call the native Swift code
  //     final bool result = await _channel.invokeMethod('invalidate');
  //
  //     return result;
  //   } catch (e) {
  //     debugPrint("invalidate call to ios / swift platform failed.");
  //     rethrow;
  //   }
  // }
}
