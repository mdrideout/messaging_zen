import Flutter
import UIKit

public class SwiftMessagingZenIosPlugin: NSObject, FlutterPlugin {
    enum InvokableMethods: String {
        case logger = "logger"
    }

    let TAG = "[SwiftMessagingZenIosPlugin]"
    private var channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "plugins.flutter.io/messaging_zen_ios", binaryMessenger: registrar.messenger())
        let instance = SwiftMessagingZenIosPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("\(TAG) - Swift handle() function called.")
        
        
        let method = call.method;
        let arguments = call.arguments as? Dictionary<String, Any>
        
        // Create a MessagingZen instance and pass our FlutterMethodChannel so that it can communicate back to Flutter
        let messagingZen = MessagingZen(channel: channel, plugin: self);
        
        switch(method) {
        case "initialize":
            print("Calling invokeMethod from swift back to Flutter.")
            self.channel.invokeMethod(InvokableMethods.logger.rawValue, arguments: ["arg1": "arg1 value", "arg2": "arg2 value"])
            
            print("Calling messagingZen initialize function")
            let initResult = messagingZen.initialize(key: "to be provided")
            
            result(initResult)
            break;
            
        case "show":
            result("\(TAG) - show() function called on federated messaging_zen_ios plugin - SWIFT CODE.")
            break
            
        default: result(FlutterMethodNotImplemented)
        }
    }
}
