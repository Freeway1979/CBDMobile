//
//  DeviceListManager.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React

@objc(DeviceListManager)
class DeviceListManager: NSObject {
    
    @objc var bridge: RCTBridge!
    
    @objc class func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func popMessage(_ reactTag: NSNumber, message: String, callback: RCTResponseSenderBlock) {
        //NSLog("%@", message)
        callback([NSNull(), ["result": "success"]]);
        DispatchQueue.main.async {
            if let view = self.bridge.uiManager.view(forReactTag: reactTag) {
                let presentedViewController = view.reactViewController()
                let alertController = UIAlertController(title: "Message from React Native", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                presentedViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
