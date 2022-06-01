import 'dart:async';

import 'package:flutter/material.dart';
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
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) {
    // TODO: implement initialize
    throw UnimplementedError('TODO: Implement android implementation of initialize()');
  }

  @override
  Future<bool> show() async {
    try {
      // Call the native Kotlin code
      final bool result = await _channel.invokeMethod('show');

      return result;
    } catch (e) {
      debugPrint("Initialize call to android platform failed.");
      rethrow;
    }
  }
}
