import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_messaging_zen.dart';

/// The interface that implementations of messaging_zen must implement.
///
/// Platform implementations should extend this class rather than implement it as `url_launcher`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [UrlLauncherPlatform] methods.
abstract class MessagingZenPlatform extends PlatformInterface {
  /// Constructs a MessagingZenPlatform
  MessagingZenPlatform() : super(token: _token);

  /// Platform Interface Verification Pieces (see PlatformInterface docs for reasons)
  static final Object _token = Object();

  /// Create an instance from the MethodChannels implementation
  static MessagingZenPlatform _instance = MethodChannelMessagingZen();

  /// The default instance of [MessagingZenPlatform] to use
  ///
  /// Defaults to [MethodChannelMessagingZen].
  static MessagingZenPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [UrlLauncherPlatform] when they register themselves.
  static set instance(MessagingZenPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Functions that should be implemented by platform specific interfaces

  /// Initialize the Zendesk Messaging SDK
  /// Get the keys from the Zendesk Admin Center (channels -> messaging)
  /// Recommend keeping these values in environment variables.
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  });

  /// Show the Zendesk Messaging Interface
  Future<bool> show();

  /// Set the Zendesk Messaging Web Widget Z-Index
  void webWidgetSetZIndex({required int zIndex}) {
    throw UnimplementedError(
        "This method has not been implemented on this platform. webWidgetSetZIndex is for Web only.");
  }
}
