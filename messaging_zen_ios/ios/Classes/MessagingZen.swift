import ZendeskSDKMessaging
import ZendeskSDK

public class MessagingZen {
    let TAG = "[MessagingZen]"
    
    private var channel: FlutterMethodChannel? = nil
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    /// Initialize
    /// Calls Zendesk.initialize with the channel key, and it's completion handler uses the provided
    /// closure [FlutterResult] to return the result back to Flutter.
    func initialize(key: String, completionHandler: @escaping FlutterResult){
        self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Initializing Zendesk Messaging with key: \(key)\n")
        
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
    
//    /// Invalidate
//    /// Calls Zendesk.invalidate to invalidate the existing initialization
//    func invalidate(completionHandler: @escaping FlutterResult) {
//        self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Dismissing the viewController and Invalidating Zendesk Messaging Instance")
//
//        // Can we clear the iOS cache for Zendesk?
//        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
//            let fileManager = FileManager.default
//            do {
//                // Get the directory contents urls (including subfolders urls)
//                let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
//                for file in directoryContents {
//                    do {
//                        self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - File Found: \(file.path)")
//                        try fileManager.removeItem(at: file)
//                    }
//                    catch let error as NSError {
//                        debugPrint("Ooops! Something went wrong: \(error)")
//                    }
//
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//
////        // Get the Zendesk UIViewController
////        guard let viewController = Zendesk.instance?.messaging?.messagingViewController() else {
////            self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Zendesk.instance?.messaging?.messagingViewController() failed.")
////            completionHandler(false)
////            return
////        }
//
////        viewController.removeFromParent()
//
//        // Dismiss the view controller
////        viewController.dismiss(animated: true, completion: nil);
//
//        // Get the root view controller
//        guard let rootViewController: UIViewController = UIApplication.shared.delegate?.window??.rootViewController else {
//            self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - Unable to get rootViewController: UIViewController")
//            completionHandler(false)
//            return
//        }
//
////        rootViewController.dismiss(animated: true);
//
//        let children = rootViewController.children;
//
//        for viewController in children {
//            self.channel?.invokeMethod("logger", arguments: "\(self.TAG) - \(viewController.debugDescription)")
//            print(viewController.debugDescription)
//        }
//
//        // Invalidate the Zendeks instance
//        Zendesk.invalidate();
//
//        completionHandler(true)
//    }
    
}
