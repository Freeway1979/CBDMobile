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
        self.rctRootView?.appProperties = parameters as [NSObject : AnyObject];
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
