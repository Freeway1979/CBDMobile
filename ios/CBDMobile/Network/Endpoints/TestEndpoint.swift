//
//  TestEndpoint.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum TestEndpoint {
    
    case readUserRepos(name: String)
    
}

extension TestEndpoint: APIConvertible {
    
    var baseURL: String {
        "https://api.github.com"
    }
    
    var method: HTTPMethod {
        switch self {
        case .readUserRepos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .readUserRepos(let name):
            return "users/\(name)/repos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .readUserRepos(_):
            return nil
        }
    }
    
}
