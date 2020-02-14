//
//  RNViewController.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React

protocol RNRTCViewSetup {
    func setRCTRootView(_ rtcView: RCTRootView, params: [String: Any])
}

class RNViewController: UIViewController {
    
    var rctRootView: RCTRootView?
    var params: [String: Any]?
    
    func loadData(parameters: [String: Any]) {
        // load from local db or network
        self.rctRootView?.appProperties = parameters
    }
    
    func refresh(_ data: [String: Any]) {
        showSpinner(onView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadData(parameters: data)
            self.removeSpinner()
        }
    }

}

extension RNViewController: RNRTCViewSetup {
    func setRCTRootView(_ rtcView: RCTRootView, params: [String : Any]) {
        self.view = rtcView
        self.rctRootView = rtcView
        rtcView.appProperties = params
    }
}
