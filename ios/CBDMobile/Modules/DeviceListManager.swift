//
//  DeviceListManager.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React
import Alamofire

@objc(DeviceListManager)
class DeviceListManager: RCTEventEmitter {
    
    override func supportedEvents() -> [String]! {
        return ["DeviceListManagerEvent", "DeviceListManagerAPIFailure"]
    }
    
    override class func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func popMessage(_ reactTag: NSNumber, message: String) {
        DispatchQueue.main.async {
            if let view = self.bridge.uiManager.view(forReactTag: reactTag) {
                let presentedViewController: UIViewController! = view.reactViewController()
                let alertController = UIAlertController(title: "Message from React Native", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                presentedViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func refreshData() {
        AF.request("https://api.github.com/users/apple/repos").responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                self.sendEvent(withName: "DeviceListManagerEvent", body: data)
            case .failure(_):
                self.sendEvent(withName: "DeviceListManagerAPIFailure", body: [])
            }
        }
    }
    
}
