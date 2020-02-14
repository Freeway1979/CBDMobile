//
//  ViewController.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React
import Realm
import RealmSwift

protocol RNSetRTCView {
    func setRCTRootView(_ rtcView: RCTRootView, params: [String: Any])
}

extension UIViewController: RNSetRTCView {
    func setRCTRootView(_ rtcView: RCTRootView, params: [String : Any]) {
        self.view = rtcView
        rtcView.appProperties = params
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var buttonGoRN: UIButton!
    
    static var rootViewController: UIViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HomeViewController.rootViewController = self
        self.tabBarController?.navigationItem.title = "Home"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Home"
        
        print(NSHomeDirectory())
        
        let mockData: [String: Any] = ["members":
            [
                ["name":"Alex", "age":"42"],
                ["name":"Joel", "age":"10"]
            ]
        ]
        let rootView = MixerReactModule.sharedInstance.viewForModule("RNHelloWorld", initialProperties: mockData)
        setRCTRootView(rootView, params: mockData)
        
        testRealm()
    }

    func testRealm() {
        let site = Site()
        site.name = "TestSite"
        site.country = "CN"
        
        // Get the default Realm
        let realm = try! Realm()

        // Query Realm for all sites
        let sites = realm.objects(Site.self).filter("country == 'CN'")
        print(sites.count) // => 0 

        // Persist your data easily
        try! realm.write {
            realm.add(site)
        }

        // Queries are updated in realtime
        print(sites.count) // => 1

        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theSite = realm.objects(Site.self).filter("country == 'CN'").first
                try! realm.write {
                    theSite!.country = "BR"
                }
            }
        }
    }

}

