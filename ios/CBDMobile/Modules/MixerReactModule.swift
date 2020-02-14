//
//  MixerReactModule.swift
//  CBDMobile
//
//  Created by Fei Song on 2020/2/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import React

class MixerReactModule: NSObject {
    
    static let sharedInstance = MixerReactModule()
    
    var bridge: RCTBridge?
    
    func createBridgeIfNeeded() -> RCTBridge {
        if bridge == nil {
            bridge = RCTBridge(delegate: self, launchOptions: nil)
        }
        return bridge!
    }
    
    func viewForModule(_ moduleName: String, initialProperties: [String: Any]?) -> RCTRootView {
        let viewBridge = createBridgeIfNeeded()
        let rootView = RCTRootView(bridge: viewBridge, moduleName: moduleName, initialProperties: initialProperties)
        return rootView
    }
    
}

extension MixerReactModule: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        return URL(string: "http://localhost:8081/index.bundle?platform=ios")
    }
}

