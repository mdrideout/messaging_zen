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
        
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "messagingZenIosView")
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("\(TAG) - Swift handle() function called.")
        
        let method = call.method;
        let arguments = call.arguments as? Dictionary<String, Any>
        
        // Create a MessagingZen instance and pass our FlutterMethodChannel so that it can communicate back to Flutter
        let messagingZen = MessagingZen(channel: channel, plugin: self);
        
        switch(method) {
        case "initialize":
            self.channel.invokeMethod(InvokableMethods.logger.rawValue, arguments: "\(TAG) - Calling messagingZen.initialize()")
            let key: String = (arguments?["key"] ?? "") as! String
            
            // Pass the FlutterResult closure to the initialize function
            messagingZen.initialize(key: key, completionHandler: result)
            break;
            
        case "show":
            result("\(TAG) - Calling messagingZen.show()")
            break
            
        default: result(FlutterMethodNotImplemented)
        }
    }
}
