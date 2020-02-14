//
//  DevicesViewController.swift
//  CBDMobile
//
//  Created by Fei Song on 2020/2/11.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React

class DevicesViewController: UIViewController {
    
    var rctRootView: RCTRootView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Devices"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.title = "Devices"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mockData: [String: Any] = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        
        let rootView = MixerReactModule.sharedInstance.viewForModule("RNDeviceList", initialProperties: mockData)
        setRCTRootView(rootView, params: mockData)
    }

}
