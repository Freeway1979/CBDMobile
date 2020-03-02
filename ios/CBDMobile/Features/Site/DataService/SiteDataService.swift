//
//  SiteDataService.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class SiteDataService {
    static let `default` = SiteDataService()
}

// MARK: Append

extension SiteDataService: DataServiceAppend {
    typealias ObjectType = Site
}

// MARK: Remove

extension SiteDataService: DataServiceDelete { }

// MARK: Update

extension SiteDataService: DataServiceUpdate { }

// MARK: Read

extension SiteDataService: DataServiceRetrive { }
