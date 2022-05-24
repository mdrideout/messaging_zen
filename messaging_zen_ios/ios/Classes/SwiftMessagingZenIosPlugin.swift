import Flutter
import UIKit

public class SwiftMessagingZenIosPlugin: NSObject, FlutterPlugin {
  let TAG = "[SwiftMessagingZenIosPlugin]"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "plugins.flutter.io/messaging_zen_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftMessagingZenIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("\(TAG) - Swift handle() function called.")

    let method = call.method;
    let arguments = call.arguments as? Dictionary<String, Any>

    switch(method) {
        case "show":
            result("\(TAG) - show() function called on federated messaging_zen_ios plugin - SWIFT CODE.")
            break

        default: result(FlutterMethodNotImplemented)
    }
  }
}
