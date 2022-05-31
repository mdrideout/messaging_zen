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
        self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Initializing MessagingZen with iOS key: \(key)\n")
        
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
    
    /// Show
    /// Calls Zendesk.show to reveal the native zendesk messaging view
    func show(completionHandler: @escaping FlutterResult) {
        self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Getting the Zendesk UIViewController to present.")
        
        // Get the Zendesk UIViewController
        guard let viewController = Zendesk.instance?.messaging?.messagingViewController() else {
            self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Zendesk.instance?.messaging?.messagingViewController() failed.")
            completionHandler(false)
            return
        }
        
        // Get the root view controller
        guard let rootViewController: UIViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Unable to get rootViewController: UIViewController")
            completionHandler(false)
            return
        }
        
        // Show the view
        rootViewController.present(viewController, animated: true, completion: {
            completionHandler(true)
        })
    }
    
}
