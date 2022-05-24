import 'dart:async';

import 'package:flutter/services.dart';

import 'messaging_zen_platform_interface.dart';

/// A named channel for communicating with platform plugins using asynchronous method calls.
const MethodChannel _channel = MethodChannel('plugins.flutter.io/messaging_zen');

/// An implementation of [MessagingZenPlatform] that uses method channels
class MethodChannelMessagingZen implements MessagingZenPlatform {
  /// Initialize the Zendesk Messaging SDK
  @override
  Future<void> initialize() async {
    throw UnimplementedError('initialize() has not been implemented. TODO: Call a platform channel.');
  }

  /// Check whether Zendesk Messaging SDK is initialized
  @override
  Future<bool> checkInitialized() {
    // TODO: implement checkInitialized
    throw UnimplementedError();
  }

  /// Show the Zendesk Messaging Interface
  @override
  Future<void> show() async {
    print("show() function called on federated messaging_zen_platform_interface plugin.");

    return _channel.invokeMethod<void>('show');
  }
}
