//
//  APIConfig.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/19.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConvertible: URLRequestConvertible {
    
    // must be implemented
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    
    // has default implementation
    var baseURL: String { get }
    var encoding: ParameterEncoding { get }
    func asURLRequest() throws -> URLRequest
}

extension APIConvertible {
    
    var baseURL: String {
        switch APIManager.apiEnvironment {
        case APIEnvironment.dev:
            return APIConstant.DevServer.URL
        case APIEnvironment.staging:
            return APIConstant.StagingServer.URL
        case APIEnvironment.production:
            return APIConstant.ProductionServer.URL
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(APIConstant.timeoutSeconds)
        
        let encodedURLRequest = try encoding.encode(request, with: parameters)
        
        return encodedURLRequest
    }
}
