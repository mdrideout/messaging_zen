import ZendeskSDKMessaging
import ZendeskSDK

public class MessagingZen {
    let TAG = "[MessagingZen]"
    
    private var channel: FlutterMethodChannel? = nil
    private var plugin: SwiftMessagingZenIosPlugin? = nil
    init(channel: FlutterMethodChannel, plugin: SwiftMessagingZenIosPlugin) {
        self.channel = channel
        self.plugin = plugin
    }
    
    /// Initialize
    /// Calls Zendesk.initialize with the channel key, and it's completion handler uses the provided
    /// closure [FlutterResult] to return the result back to Flutter.
    func initialize(key: String, completionHandler: @escaping FlutterResult){
        print("\(self.TAG) - Initializing MessagingZen with iOS key: \(key)\n")
        
        Zendesk.initialize(withChannelKey: key, messagingFactory: DefaultMessagingFactory()) { result in
            if case let .failure(error) = result {
                self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Zendesk Messaging did not initialize.\nError: \(error.localizedDescription)")
                completionHandler(false)
            } else {
                self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Zendesk Messaging initialization was successful.")
                completionHandler(true)
            }
            
        }
    
    }
    
}
