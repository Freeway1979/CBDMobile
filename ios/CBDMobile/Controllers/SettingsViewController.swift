//
//  SettingsViewController.swift
//  CBDMobile
//
//  Created by Fei Song on 2020/2/11.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.title = "Settings"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.title = "Settings"
    }

}
