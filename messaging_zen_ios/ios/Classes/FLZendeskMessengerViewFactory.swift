import Flutter
import UIKit
import ZendeskSDKMessaging
import ZendeskSDK

public class FLZendeskMessengerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var channel: FlutterMethodChannel
    
    init(messenger: FlutterBinaryMessenger, channel: FlutterMethodChannel) {
        self.messenger = messenger
        self.channel = channel
        super.init()
    }
    
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLZendeskMessengerView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            channel: channel
        )
    }
}

public class FLZendeskMessengerView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var channel: FlutterMethodChannel
    
    let TAG = "[FLZendeskMessengerView]"
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        channel: FlutterMethodChannel
    ) {
        _view = UIView()
        self.channel = channel
        super.init()
        
        // iOS views can be created here
        createZendeskMessagingView(view: _view)
    }
    
    public func view() -> UIView {
        return _view
    }
    
    func createZendeskMessagingView(view _view: UIView) {
        guard let uiViewController = Zendesk.instance?.messaging?.messagingViewController() else {
            self.channel.invokeMethod("logger", arguments: "\(self.TAG) - Zendesk.instance?.messaging?.messagingViewController() failed. Was Zendesk initialized?")
            return
        }
        // Get the Zendesk Messaging UIView from the UIViewController
        let zendeskMessagingView: UIView = uiViewController.view
        
        zendeskMessagingView.layoutSubviews()
        
        // Add the Zendesk Messaging UIView as a subview
        _view.addSubview(zendeskMessagingView)
        
        

//        let navigationController = UIApplication.shared.windows.first!.rootViewController;
//        navigationController?.show(uiViewController, sender: self);
        
        
    }
}
//
//  FLZendeskMessengerViewFactory.swift
//  messaging_zen_ios
//
//  Created by Matthew Rideout on 5/29/22.
//

import Foundation
