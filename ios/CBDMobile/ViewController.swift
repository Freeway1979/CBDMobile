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

class ViewController: UIViewController {

    @IBOutlet weak var buttonGoRN: UIButton!
    
    static var rootViewController: UIViewController?
    
    var params: NSDictionary?
    var rctview: RCTRootView?
    
    var jsCodeLocation: URL? {
        let path = Bundle.main.path(forResource: "main", ofType: "jsbundle")!
        let url = URL(fileURLWithPath: path)
        return url
    }
    
    @IBAction func onButtonClicked(_ sender: UIButton) {
        let jsCode:URL?
        #if DEBUG
         jsCode = URL(string: "http://localhost:8081/index.bundle?platform=ios")
        #else
         jsCode = self.jsCodeLocation
        #endif

        let mockData:NSDictionary = ["members":
            [
                ["name":"Alex", "age":"42"],
                ["name":"Joel", "age":"10"]
            ]
        ]

        let vc = RNViewController()
        let rootView = RCTRootView(
            bundleURL: jsCode!,
            moduleName: "RNHelloWorld",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
//        vc.view = rootView
        vc.title = "React Native"
        vc.setRCTRootView(rctRootView: rootView, params: mockData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewController.rootViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(NSHomeDirectory())
        
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

