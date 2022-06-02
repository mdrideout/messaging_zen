import Flutter
import UIKit

public class SwiftMessagingZenIosPlugin: NSObject, FlutterPlugin {
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
        let messagingZen = MessagingZen(channel: channel);
        
        switch(method) {
        case "initialize":
            self.channel.invokeMethod("logger", arguments: "\(TAG) - Calling messagingZen.initialize()")
            let key: String = (arguments?["key"] ?? "") as! String
            
            // Pass the FlutterResult closure to the initialize function
            messagingZen.initialize(key: key, completionHandler: result)
            break
            
        case "show":
            self.channel.invokeMethod("logger", arguments: "\(TAG) - Calling messagingZen.show()")
            
            // Pass the FlutterResult closure to the show function
            messagingZen.show(completionHandler: result)
            break
            
        default: result(FlutterMethodNotImplemented)
        }
    }
}
