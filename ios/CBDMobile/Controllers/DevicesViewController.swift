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
        TestInteractor().getUserRepos(with: "apple") { (repos) in
            guard let repos = repos else { return }
            self.rctRootView?.appProperties = ["repos": repos]
        }
    }
    
    func testRealm() {
        let site1 = Site()
        site1.country = "CN"
        site1.name = "first"
        
        let site2 = Site()
        site2.country = "USA"
        site2.name = "second"
        
        SiteDataService.default.append(site1, mode: .localOnly) { error in
            if error == nil {
                print("DataService: Site stored success")
            }
        }
        
        SiteDataService.default.retrive(mode: .localOnly) { result in
            switch result {
            case .success(.local(let list)):
                print("DataService: \(list)")
            default:
                break
            }
        }
        
        
//        SiteDataService.default.appendSitesIntoDB([site1, site2], completion: nil)
//
//        SiteDataService.default.getSiteList { result in
//            switch result {
//            case .success(let dataResult):
//                switch dataResult {
//                case .network(let sites):
//                    print("Site list from network: \(sites)")
//                case .local(let sites):
//                    print("Site list from network: \(sites)")
//                }
//            case .failure(_):
//                print("Error when fetch data in realm.")
//            }
//        }
//
//        SiteDataService.default.deleteAllSites(completion: nil)
        
        
    }
}
