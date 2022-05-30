@JS() // sets the context, in this case being `window`
library main; // required library declaration

import 'package:js/js.dart';

/// Test Alert
/// Test function to check that the JS has loaded
@JS('testAlert')
external void testAlert();

/// Await Script Load
/// Returns a promise that resolves when the script has loaded.
/// [scriptId] is the ID of the script we are awaiting to load, including the '#' symbol
/// Awaiting dart function must wrap with promiseToFuture to convert the promise to a future.
@JS('awaitScriptLoad')
external Future<void> awaitScriptLoad(String scriptId);

/// Open the Zendesk Messenger
@JS('openZendeskMessenger')
external Future<bool> openZendeskMessenger();
