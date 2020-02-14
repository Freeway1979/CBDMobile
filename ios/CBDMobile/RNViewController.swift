//
//  RNViewController.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import React

class RNViewController: UIViewController {

    var rctRootView: RCTRootView?
    var params: NSDictionary?
    
    func setRCTRootView(rctRootView:RCTRootView, params: NSDictionary) {
        self.rctRootView = rctRootView
        self.params = params
        self.view = rctRootView
    }
    
    func loadData(parameters: NSDictionary) {
        // load from local db or network
        self.rctRootView?.appProperties = parameters as! [String : Any];
    }
    
    func saveData(parameters: NSDictionary) {
        
    }
    
    func timerChange() {
        showSpinner(onView: self.view)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            let mockData:NSDictionary = ["members":
                [
                    ["name":"Alex", "age":"60"],
                    ["name":"Joel", "age":"20"]
                ]
            ]
            self.loadData(parameters: mockData)
            self.removeSpinner()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerChange()
    }

}
