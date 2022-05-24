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
  Future<void> initialize() async {
    // Get environment variables needed for initialization
    const String? webScriptId = String.fromEnvironment("WEB_SCRIPT_ID");
    const String? webScriptSrc = String.fromEnvironment("WEB_SCRIPT_SRC");

    // Empty Checks (for default environment value of "")
    if (webScriptId == "") {
      throw ("webScriptSrc cannot be \"\". Ensure WEB_SCRIPT_SRC environment variable is defined.");
    }

    if (webScriptSrc == "") {
      throw ("webScriptId cannot be \"\". Ensure WEB_SCRIPT_ID environment variable is defined.");
    }

    try {
      logger.d("Initializing the messaging_zen_web instance.");

      // Inject our own messaging_zen JavaScript
      await _injectMessagingZenCommands();

      // Inject the Zendesk Messaging SDK
      await injectJavaScriptSrc(scriptId: webScriptId, scriptSrc: webScriptSrc);

      return;
    } catch (e) {
      rethrow;
    }
  }

  /// Check Initialized
  /// Checks whether the Zendesk Messenger SDK has been initialized
  @override
  Future<bool> checkInitialized() async {
    // Get environment variable needed for check
    const String? webScriptId = String.fromEnvironment("WEB_SCRIPT_ID");

    // Empty Checks (for default environment value of "")
    if (webScriptId == "") {
      throw ("webScriptSrc cannot be \"\". Ensure WEB_SCRIPT_SRC environment variable is defined.");
    }

    // Check if the Zendesk Messenger SDK exists
    bool _scriptExistsSDK = checkScriptExists(webScriptId);
    bool _scriptExistsCommands = checkScriptExists(messagingZenWebCommandsScriptId);

    // Return true if both scripts exist, else false
    return (_scriptExistsSDK && _scriptExistsCommands);
  }

  /// Show Zendesk Messenger
  /// Sends the command to the Zendesk SDK API open the chat interface.
  ///
  /// Will initialize the JavaScripts if not already existing in the DOM.
  @override
  Future<void> show() async {
    // Check if the Zendesk Messenger SDK is initialized
    bool _initialized = await checkInitialized();

    // If not initialized, initialize
    if (!_initialized) {
      await initialize();
    }

    // Open Zendesk Messenger
    openZendeskMessenger();
  }

  /// Inject messaging_zen JS commands
  /// Inject our messaging_zen_web_commands.js that we use to interface with the Zendesk Messaging web SDK
  Future<void> _injectMessagingZenCommands() async {
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
  }
}
