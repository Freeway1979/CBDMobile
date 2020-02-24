//
//  SiteEndpoint.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum SiteEndpoint {
    
    case readSites
    case readSite(name: String)
    case createSite(parameters: Parameters)
    case updateSite(name: String, parameters: Parameters)
    case deleteSite(name: String)
    
}

extension SiteEndpoint: APIConvertible {
    
    var method: HTTPMethod {
        switch self {
        case .readSites, .readSite:
            return .get
        case .createSite:
            return .post
        case .updateSite:
            return .put
        case .deleteSite:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .readSites,
             .createSite(_):
            return "/sites"
        case .readSite(let name),
             .updateSite(let name, _),
             .deleteSite(let name):
            return "/sites/\(name)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .readSites,
             .readSite,
             .deleteSite:
            return nil
        case .createSite(let parameters),
             .updateSite(_, let parameters):
            return parameters
        }
    }
    
}
