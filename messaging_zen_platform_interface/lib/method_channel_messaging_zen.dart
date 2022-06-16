import 'dart:async';

import 'messaging_zen_platform_interface.dart';

/// An implementation of [MessagingZenPlatform] that uses method channels
class MethodChannelMessagingZen implements MessagingZenPlatform {
  /// Initialize the Zendesk Messaging SDK
  @override
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> show() async {
    throw UnimplementedError();
  }

  @override
  void webRefreshBrowser() {
    throw UnimplementedError();
  }

  @override
  void webWidgetResetCookies() {
    throw UnimplementedError();
  }

  @override
  void webWidgetSetZIndex({required int zIndex}) {
    throw UnimplementedError();
  }

  @override
  void webWidgetSetLocale({required String languageTag}) {
    throw UnimplementedError();
  }
}
