import 'dart:async';

import 'package:flutter/services.dart';
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
  Future<void> initialize() {
    throw UnimplementedError('initialize() has not been implemented on iOS');
  }

  @override
  Future<bool> checkInitialized() {
    // TODO: implement checkInitialized
    throw UnimplementedError();
  }

  @override
  Future<void> show() async {
    print("show() function called on federated messaging_zen_ios plugin - DART CODE.");

    // Call the native Swift code
    final String? result = await _channel.invokeMethod('show');

    print("Returned result from Swift: $result");

    return;
  }
}
