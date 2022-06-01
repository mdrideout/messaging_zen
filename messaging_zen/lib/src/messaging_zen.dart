import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// Wrapper class for callable methods
class MessagingZen {
  final String? webScriptId;
  final String? webScriptSrc;
  final String? iosChannelKey;
  final String? androidChannelKey;

  MessagingZen({this.webScriptId, this.webScriptSrc, this.iosChannelKey, this.androidChannelKey});

  /// Initialize the Zendesk Messaging SDK
  Future<bool> initialize() async {
    return await MessagingZenPlatform.instance.initialize(
      webScriptId: webScriptId,
      webScriptSrc: webScriptSrc,
      iosChannelKey: iosChannelKey,
      androidChannelKey: androidChannelKey,
    );
  }

  /// Show the Zendesk Messaging interface
  Future<bool> show() async {
    return await MessagingZenPlatform.instance.show();
  }

  /// Change the Zendesk Messaging Web Widget Z-Index
  void webWidgetSetZIndex(int zIndex) {
    return MessagingZenPlatform.instance.webWidgetSetZIndex(zIndex: zIndex);
  }
}
