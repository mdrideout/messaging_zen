import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// Wrapper class for callable methods
class MessagingZen {
  final String? webScriptId;
  final String? webScriptSrc;
  final String? iosChannelKey;
  final String? androidChannelKey;

  MessagingZen({this.webScriptId, this.webScriptSrc, this.iosChannelKey, this.androidChannelKey});

  /// Initialize the Zendesk Messaging SDK
  Future<void> initialize() async {
    return await MessagingZenPlatform.instance.initialize(
      webScriptId: webScriptId,
      webScriptSrc: webScriptSrc,
      iosChannelKey: iosChannelKey,
      androidChannelKey: androidChannelKey,
    );
  }

  // /// Check if the Zendesk Messaging SDK is initialized
  // Future<bool> checkInitialized() async {
  //   return await MessagingZenPlatform.instance.checkInitialized(webScriptId: webScriptId);
  // }

  /// Show the Zendesk Messaging interface
  Future<void> show() async {
    return await MessagingZenPlatform.instance.show(webScriptId: webScriptId);
  }
}
