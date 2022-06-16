import 'dart:html' as html;
import 'dart:js_util';

import 'js_interop.dart';
import 'util/logger.dart';

/// Inject JavaScript String
/// Injects a new JavaScript <script id="id"></script> tag into the HTML DOM
/// and then injects the JavaScript SRC string into the tag.
///
/// [scriptId] should not include the "#" symbol
/// [scriptString] is the JavaScript file content as a string.
void injectJavaScriptString({required String scriptId, required String scriptString}) {
  // Check if the script already exists so we don't add it more than once
  bool _scriptExists = checkScriptExists(scriptId);

  // Only add if the script does not exist to avoid adding multiple instances to the DOM
  if (!_scriptExists) {
    logger.d("$scriptId script does not exist, adding it to <head> via String inject.");

    // Create the script element
    html.ScriptElement _scriptElement = html.ScriptElement();

    // Add the script id
    _scriptElement.id = scriptId;

    // Inject JavaScript into the <script> element
    _scriptElement.innerText = scriptString;

    // Inject the script to the end of the <body> in the DOM
    html.document.head?.children.add(_scriptElement);
  } else {
    logger.d("$scriptId script already exists in DOM.");
  }

  return;
}

/// Inject JavaScript Src
/// Injects a new JavaScript <script src="x"> element into the HTML DOM
/// using the src parameter and waits for it to finish loading before returning
/// using await promiseToFuture(awaitScriptLoad("#sciptId"));
///
/// [scriptId] should not include the "#" symbol
/// [scriptSrc] is the value for the "src" parameter of the <script src="x"> tag.
Future<void> injectJavaScriptSrc({required String scriptId, required String scriptSrc}) async {
  // Check if the script already exists so we don't add it more than once
  bool _scriptExists = checkScriptExists(scriptId);

  // Only add if the script does not exist to avoid adding multiple instances to the DOM
  if (!_scriptExists) {
    logger.d("$scriptId script does not exist, adding it to <head> via src tag.");

    // Create the script element
    html.ScriptElement _scriptElement = html.ScriptElement();

    // Add the script id
    _scriptElement.id = scriptId;

    // // Add the script src
    _scriptElement.src = scriptSrc;

    // Load synchronously
    _scriptElement.async = false;

    // Do not defer loading
    _scriptElement.defer = false;

    // Inject the script to the end of the <body> in the DOM
    html.document.head?.children.add(_scriptElement);

    // Wait for the script to load so we can call commands against it (include '#' symbol for the ID selection)
    await promiseToFuture(awaitScriptLoad("#$scriptId"));
  } else {
    logger.d("$scriptId script already exists in DOM.");
  }

  return;
}

/// Check Script Exists
/// Returns true or false based on whether the script exists in the HTML DOM
/// [scriptId] should not include the "#" symbol
bool checkScriptExists(String scriptId) {
  html.Element? _scriptExists = html.document.getElementById(scriptId);

  // Only add if the script does not exist to avoid adding multiple instances to the DOM
  if (_scriptExists == null) {
    return false;
  } else {
    return true;
  }
}

/// Remove Script From DOM
/// Removes the <script> with the provided id from the HTML dom
/// Returns true if the script was successfully removed
///
/// NOTICE: Script remains in memory and can be executed against.
/// Replacing script with different url parameters will not change
/// initialization of the old script with old params.
bool removeScriptFromDom(String scriptId) {
  // If the script does not exist, return true
  bool _scriptExists = checkScriptExists(scriptId);
  if (!_scriptExists) {
    return true;
  }

  html.Element? _scriptElement = html.document.getElementById(scriptId);

  // Null check
  if (_scriptElement == null) {
    return true;
  }

  // Remove the script
  _scriptElement.remove();

  // Check if script exists again
  _scriptExists = checkScriptExists(scriptId);
  if (!_scriptExists) {
    return true;
  }

  // Else, return false
  return false;
}
