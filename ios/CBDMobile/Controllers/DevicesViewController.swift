//
//  DevicesViewController.swift
//  CBDMobile
//
//  Created by Fei Song on 2020/2/11.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React

class DevicesViewController: RNViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Devices"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let newMockData: [String: Any] = ["scores":
            [
                ["name":"Peter", "value":"22"],
                ["name":"Lily", "value":"40"]
            ]
        ]
        refresh(newMockData)
    }

}
