import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';

/// Wrapper class for callable methods
class MessagingZen {
  final String nickname;
  final String? webScriptId;
  final String? webScriptSrc;
  final String? iosChannelKey;
  final String? androidChannelKey;

  MessagingZen(
      {required this.nickname, this.webScriptId, this.webScriptSrc, this.iosChannelKey, this.androidChannelKey});

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

  void webRefreshBrowser() {
    return MessagingZenPlatform.instance.webRefreshBrowser();
  }

  /// Change the Zendesk Messaging Web Widget Locale
  void webWidgetSetLocale(String languageTag) {
    return MessagingZenPlatform.instance.webWidgetSetLocale(languageTag: languageTag);
  }

  /// Reset the Zendesk Messaging cookies to clear chat history
  void webWidgetResetCookies() {
    return MessagingZenPlatform.instance.webWidgetResetCookies();
  }

  /// Change the Zendesk Messaging Web Widget Z-Index
  void webWidgetSetZIndex(int zIndex) {
    return MessagingZenPlatform.instance.webWidgetSetZIndex(zIndex: zIndex);
  }

  /// Sets the web widget z-index to default SDK value of 999999
  void webWidgetShow() {
    return MessagingZenPlatform.instance.webWidgetSetZIndex(zIndex: 999999);
  }

  /// Sets the web widget z-index to value of -1000 (which should put it behind the flutter container in the DOM)
  void webWidgetHide() {
    return MessagingZenPlatform.instance.webWidgetSetZIndex(zIndex: -1000);
  }
}
