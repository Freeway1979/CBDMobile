//
//  DevicesViewController.swift
//  CBDMobile
//
//  Created by Fei Song on 2020/2/11.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React
import Alamofire

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
        
        let mockData = [ "repos": [
            [
                "id": 170908616,
                "node_id": "MDEwOlJlcG9zaXRvcnkxNzA5MDg2MTY=",
                "name": ".github",
                "full_name": "google/.github"
            ],
            [
                "id": 143044068,
                "node_id": "MDEwOlJlcG9zaXRvcnkxNDMwNDQwNjg=",
                "name": "0x0g-2018-badge",
                "full_name": "google/0x0g-2018-badge"
            ],
            [
                "id": 91820777,
                "node_id": "MDEwOlJlcG9zaXRvcnk5MTgyMDc3Nw==",
                "name": "abpackage",
                "full_name": "google/abpackage"
            ]
            ]
        ]
        
        let rootView = MixerReactModule.sharedInstance.viewForModule("RNDeviceList", initialProperties: ["repos": mockData])
        setRCTRootView(rootView)
        
        fetchData()
    }
    
    func fetchData() {
        self.rctRootView?.appProperties = nil
        TestInteractor().getUserRepos(with: "apple") { (repos) in
            guard let repos = repos else { return }
            self.rctRootView?.appProperties = ["repos": repos]
        }
    }
    
}
