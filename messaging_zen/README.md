# MessagingZen

A Zendesk Messaging federated Flutter plugin for Android, iOS, and Web. This uses the newer Zendesk "messaging" channel.

- Web: Implements the [Zendesk Messaging Web SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/getting_started/) 
with Dart and JS interop, to inject the SDK and perform API commands against it.
- Android: Implements the [Zendesk Messaging Android SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/android/getting_started/)
- iOS: Implements the [Zendesk Messaging iOS SDK](https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/ios/getting_started/),

# Implementation

## Example
- See the [messaging_zen_flutter_client_spike](https://github.com/mdrideout/messaging_zen/tree/main/messaging_zen_flutter_client_spike)
repository for an implementation example. Channel keys and web SDK params can be loaded with --dart-define.
  
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

**To hide the web widget, use the `webWidgetSetZIndex(-1000)` command. Return to z-index of 999999 for it to reappear.**