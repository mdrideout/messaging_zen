# MessagingZen

A Zendesk Messaging federated Flutter plugin for Android, iOS, and Web. This uses the newer [Zendesk "messaging"](https://support.zendesk.com/hc/en-us/articles/4408882490778-Introducing-messaging) channel SDK, not ["Zendesk Chat"](https://support.zendesk.com/hc/en-us/articles/4408834108186-Messaging-vs-live-chat-Which-is-right-for-you-).

- Web: Implements the [Zendesk Messaging Web SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/getting_started/) 
with Dart and JS interop, to inject the SDK and perform API commands against it.
- Android: Implements the [Zendesk Messaging Android SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/android/getting_started/)
- iOS: Implements the [Zendesk Messaging iOS SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/ios/getting_started/),

## Zendesk SDK Limitations and Known Issues
Please review the limitations and known issues for both the [iOS](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/ios/known_issues/) and [Android](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/android/known_issues/) SDKs.
The Messaging SDK is relatively new and has many limitations.

**Example: Messaging Channel Key Limitations**

Switching the messaging channel keys at post-compile-time is not supported. 
The chat conversation history appears to be based on the app's unique installation-attached GUID.
Changing the messaging channel key requires the app to be re-installed to reset the chat history
for working continued chat bot flow interactions.

The Web implementation gets around some limitations by using the [web widget API](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/sdk_api_reference/) via dart interop.
The **set cookies** command has the ability to clear the chat history.

Some limitations on native platforms can be overcome by implementing a [WebView](https://pub.dev/packages/webview_flutter) and loading static HTML pages that implement the web SDK. For example, if you need to conditionally load different messaging channel keys.

# Setup
Set up your Zendesk Messaging channels in the Zendesk Admin center. **Channels -> Messaging and social -> Messaging**.

## Android
The Android implementation requires these permissions in the AndroidManifest

**flutter_project_root/app/src/app/src/main/AndroidManifest.xml**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="xxxxxx">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    ...
```

# Implementation

## Example
Example channel keys and web SDK params can be loaded with --dart-define.

- See example flutter project in this package for a cross-platform example
- See example flutter project in messaging_zen_web for a more comprehensive web example

#### TODO: Update this section to use this package's example. Show function callouts below.

```bash

$ show an example run command here with the --dart-define keys

```

## initialize()
Initialize must take place before show() can be called.

```dart

 // Add code example here

```

## show()
Shows the Zendesk Messenger chat interface.

```dart

 // Add code example here

```


## webWidgetSetZIndex(int)
[Uses the set z-index web SDK api call](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/sdk_api_reference/#set-zindex).

Set the z-index property of the iFrame in the DOM. This can be used to move the widget behind the Flutter rendered content in order to hide the widget.

By default, all iframes in the Web Widget have a z-index value of 999999.

### TODO: Update this sections examples with the new implementation

**To hide the web widget, use the `webWidgetSetZIndex(-1000)` command. Return to z-index of 999999 for it to reappear.**