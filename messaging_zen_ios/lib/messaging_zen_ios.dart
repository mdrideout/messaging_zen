import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messaging_zen_ios/method_call_handler.dart';
import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

import 'widgets/native_view_widget.dart';

/// A named channel for communicating with platform plugins using asynchronous method calls.
const MethodChannel _channel = MethodChannel('plugins.flutter.io/messaging_zen_ios');

/// An implementation of [MessagingZenPlatform] for iOS
class MessagingZenIos extends MessagingZenPlatform {
  /// Registers this class as the default instance of [MessagingZenPlatform].
  static void registerWith() {
    MessagingZenPlatform.instance = MessagingZenIos();
  }

  @override
  Future<void> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) async {
    try {
      debugPrint("initialize() function called on federated messaging_zen_ios plugin - DART CODE.");

      // Start observing channel messages (made from native code back to Flutter)
      _channel.setMethodCallHandler(methodCallHandler);

      // Call the native initialize function
      final bool result = await _channel.invokeMethod('initialize', {"key": iosChannelKey});

      debugPrint("initialize() result from Swift: $result");

      return;
    } catch (e) {
      debugPrint("Initialize call to swift failed.");
      rethrow;
    }
  }

  // @override
  // Future<bool> checkInitialized({String? webScriptId}) {
  //   // TODO: implement checkInitialized
  //   throw UnimplementedError();
  // }

  @override
  Future<Widget?> show({String? webScriptId}) async {
    print("show() function called on federated messaging_zen_ios plugin - DART CODE.");

    // TODO: This will likely have to call native SDK API call

    // Call the native Swift code
    final String? result = await _channel.invokeMethod('show');

    print("Returned result from Swift: $result");

    // Load the native view

    return const IOSCompositionWidget();
  }

  // /// On Method Call
  // /// Handles method channel calls made from native code back to Flutter
  // static Future<dynamic> _onMethodCall(MethodCall call) async {
  //   print(
  //       "_onMethodCall handling message from iOS native Swift code: $call\ncall method: ${call.method}\ncall args: ${call.arguments}");
  // }
}
