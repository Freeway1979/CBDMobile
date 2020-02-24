//
//  APIConstant.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/19.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct APIConstant {
    
    static let timeoutSeconds = 10
    
    struct ProductionServer {
        // TODO: change to production base url
        static let URL = "https://api.testproduction.com"
    }
    
    struct StagingServer {
        // TODO: change to staging base url
        static let URL = "https://api.teststaging.com"
    }
    
    struct DevServer {
        // TODO: change to dev base url
        static let URL = "https://api.testdev.com"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
    }

    enum ContentType: String {
        case json = "application/json"
    }
}
