import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// Wrapper class for callable methods
class MessagingZen {
  /// Initialize the Zendesk Messaging SDK
  static Future<void> initialize() async {
    return await MessagingZenPlatform.instance.initialize();
  }

  /// Check if the Zendesk Messaging SDK is initialized
  static Future<bool> checkInitialized() async {
    return await MessagingZenPlatform.instance.checkInitialized();
  }

  /// Show the Zendesk Messaging interface
  static Future<void> show() async {
    return await MessagingZenPlatform.instance.show();
  }
}
