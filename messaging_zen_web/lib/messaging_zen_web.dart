import 'dart:html' as html;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:messaging_zen_platform_interface/messaging_zen_platform_interface.dart';
import 'package:messaging_zen_web/src/inject_js.dart';
import 'package:messaging_zen_web/src/js_interop.dart';

import 'src/util/logger.dart';

/// The Web Implementation of [MessagingZenPlatform]
///
/// This class implements the `package:messaging_zen` functionality for the web
class MessagingZenPlugin extends MessagingZenPlatform {
  static const messagingZenWebCommandsScriptId = "messaging-zen-commands";
  static const messagingZenWebScriptAssetPath = "packages/messaging_zen_web/assets/js/messaging_zen_web_commands.js";

  /// Registers this class as the default instance of [MessagingZenPlatform].
  static void registerWith(Registrar registrar) {
    MessagingZenPlatform.instance = MessagingZenPlugin();
  }

  /// Initialize Zendesk Messenger
  /// Will show the Zendesk Messenger chat icon in the bottom right of the screen.
  ///
  /// Optionally: To match implementations from iOS and Android, initialization does not have to happen
  /// until the user attempts to activate the chat with show().
  ///
  /// This give sthe developer the power to show / hide a Flutter UI element / button (like a FAB)
  /// that can activate the Zendesk iFrameWidget and open the chat on tap.
  @override
  Future<bool> initialize({
    String? webScriptId,
    String? webScriptSrc,
    String? iosChannelKey,
    String? androidChannelKey,
  }) async {
    assert(
      (webScriptId != null && webScriptId != ""),
      "messaging_zen_web implementation requires an webScriptId",
    );
    assert(
      (webScriptSrc != null && webScriptSrc != ""),
      "messaging_zen_web implementation requires an webScriptSrc",
    );

    // Localize variables needed for initialization on web
    final String? _webScriptId = webScriptId;
    final String? _webScriptSrc = webScriptSrc;

    // Null / Empty Checks (for default environment value of "")
    if (_webScriptId == null || _webScriptId == "") {
      throw ("webScriptSrc cannot be null or \"\".");
    }

    if (_webScriptSrc == null || _webScriptSrc == "") {
      throw ("webScriptId cannot be null or \"\".");
    }

    try {
      logger.d("Initializing the messaging_zen_web instance.");

      // Inject our own messaging_zen JavaScript
      await _injectMessagingZenCommands();

      // Inject the Zendesk Messaging SDK
      await injectJavaScriptSrc(scriptId: _webScriptId, scriptSrc: _webScriptSrc);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Show Zendesk Messenger
  /// Sends the command to the Zendesk SDK API open the chat interface.
  @override
  Future<bool> show() async {
    try {
      // Open Zendesk Messenger
      bool result = await openZendeskMessenger();

      return result;
    } catch (e) {
      logger.e(
          "Failed to open the zendesk messenger interface. The Web SDK script may not have been loaded. Has it MessagingZen been initialized?");
      rethrow;
    }
  }

  /// Refresh Page
  /// Refreshes the webpage which is necessessary if we are changing Web SDK Messaging channel Keys
  @override
  void webRefreshBrowser() {
    html.window.location.reload();
  }

  // DOES NOT WORK, SCRIPT REMAINS IN MEMORY AND CAN BE EXECUTED AGAINST.
  // /// Invalidate Zendesk Messenger
  // /// On Web, this removes the Web SDK from the DOM
  // /// Must be async to match other platforms
  // @override
  // Future<bool> invalidate({String? webScriptId}) async {
  //   assert(
  //     (webScriptId != null && webScriptId != ""),
  //     "messaging_zen_web invalidate implementation requires an webScriptId",
  //   );
  //
  //   // Localize variables needed for invalidation on web
  //   final String? _webScriptId = webScriptId;
  //
  //   // Null / Empty Checks (for default environment value of "")
  //   if (_webScriptId == null || _webScriptId == "") {
  //     throw ("webScriptSrc cannot be null or \"\".");
  //   }
  //
  //   try {
  //     logger.d("Invalidating the messaging_zen_web Zendesk Messaging SDK.");
  //
  //     // Remove the script from the SDK
  //     bool removed = removeScriptFromDom(_webScriptId);
  //
  //     return removed;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  /// Set Zendesk Messenger Locale
  /// Sends the command to the Zendesk SDK API to change the locale.
  ///
  /// If this is not called, it defaults to the browser language.
  /// [languageTag] is formatted such as "en-US" or "es-ES" with a hyphen.
  @override
  void webWidgetSetLocale({required String languageTag}) {
    webWidgetSetLocaleJS(languageTag);
    return;
  }

  /// Set Zendesk Messenger z-index
  /// Sends the command to the Zendesk SDK API to change the z-index for all iframes for the web widget.
  ///
  /// Default z-index value is 999999
  @override
  void webWidgetSetZIndex({required int zIndex}) {
    webWidgetSetZIndexJS(zIndex);
    return;
  }

  /// Zendesk Messenger reset cookies
  /// Sends the command to the Zendesk Web SDK API to disable and re-enable cookies, clearing the chat history.
  @override
  void webWidgetResetCookies() {
    webWidgetResetCookiesJS();
    return;
  }

  /// Inject messaging_zen JS commands
  /// Inject our messaging_zen_web_commands.js that we use to interface with the Zendesk Messaging web SDK
  Future<void> _injectMessagingZenCommands() async {
    logger.d("Injecting messaging_zen_web_commands.js");

    try {
      // Create an ID for this script
      const String _jsScriptId = messagingZenWebCommandsScriptId;

      // Path to the JS asset we want to inject into the new <script> tag as a string
      // Because we are inside a package, we must prefix the string with "packages/<package_name>/"
      String _jsSrcPath = messagingZenWebScriptAssetPath;

      // Load JavaScript src as a string from the .js asset file
      String? _jsSrcString = await rootBundle.loadString(_jsSrcPath);

      // Inject required JavaScript if not already in the DOM by creating the <script> tag and injecting the src js string
      injectJavaScriptString(scriptId: _jsScriptId, scriptString: _jsSrcString);

      return;
    } catch (e) {
      logger.e("Failed to inject Injecting messaging_zen_web_commands.js");
      rethrow;
    }
  }
}
