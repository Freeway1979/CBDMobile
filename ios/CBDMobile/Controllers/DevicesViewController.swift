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
        
        testRealm()
    }
    
    func fetchData() {
        self.rctRootView?.appProperties = nil
        AF.request("https://api.github.com/users/apple/repos").responseJSON { response in
            switch response.result {
            case .success(let data):
                self.rctRootView?.appProperties = ["repos": data]
            case .failure(_):
                self.rctRootView?.appProperties = nil
            }
            
        }
    }
    
    func testRealm() {
        let site = Site()
        site.name = "TestSite"
        site.country = "CN"
        
        // save
        CBDStoreManager.shared().write([site])
        // query
        let sites = CBDStoreManager.shared().query(Site.self)
        if let first = sites.first {
            CBDStoreManager.shared().update {
                first.country = "USA"
            }
            CBDStoreManager.shared().delete([first])
        }
        debugPrint(sites)
        
    }
    
}
