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
    
    // TODO: Test if InvokableMethodsEnum can be used here from the self.plugin reference.
    
    func initialize(key: String) -> Bool {
        print("\(self.TAG) - Initializing MessagingZen with iOS key: \(key)\n")
        
        var initResult: Bool = false;
        
        Zendesk.initialize(withChannelKey: key, messagingFactory: DefaultMessagingFactory()) { result in
            if case let .failure(error) = result {
                print("\(self.TAG) - Zendesk Messaging did not initialize.\nError: \(error.localizedDescription)")
                //              self.channel?.invokeMethod("test init failure response.", arguments: ["error": error.localizedDescription])
                initResult = false
            } else {
                print("\(self.TAG) - Zendesk Messaging initialization was successful.")
                //              self.channel?.invokeMethod("test init success response", arguments: [])
                initResult = true
            }
            
        }
        
        return initResult
    }
}
