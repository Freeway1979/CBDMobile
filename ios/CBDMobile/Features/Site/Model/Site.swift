//
//  Site.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/1/16.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Site: Object {
    @objc dynamic var name = ""
    @objc dynamic var country = "US"
    let devices = List<Device>()
}
