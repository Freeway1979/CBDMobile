//
//  APIManager.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum APIEnvironment {
    case dev
    case staging
    case production
}

final class APIManager {
    
    static let apiEnvironment: APIEnvironment = .dev
    
    private let session: Session
    
    private static var shardApiManager: APIManager = {
        let apiManager = APIManager(session: Session())
        return apiManager
    }()
    
    static func shared() -> APIManager {
        return shardApiManager
    }
    
    private init(session: Session) {
        self.session = session
    }
    
    func call<T: Decodable>(endpoint: APIConvertible, completion: @escaping (T?, _ statusCode: Int?, _ error: Error?) -> ()) {
        self.session.request(endpoint)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(let value):
                    completion(value, statusCode, nil)
                case .failure(let error):
                    completion(nil, statusCode, self.parseApiError(with: statusCode, error: error))
                }
        }
        
    }
    
    func call(endpoint: APIConvertible, completion: @escaping (()?, _ statusCode: Int?, _ error: Error?) -> ()) {
        self.session.request(endpoint)
            .validate()
            .response { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(_):
                    completion((), statusCode, nil)
                case .failure(let error):
                    completion(nil, statusCode, self.parseApiError(with: statusCode, error: error))
                }
        }
    }
    
//    func call(endpoint: APIConvertible, completion: @escaping (Any?, _ statusCode: Int?, _ error: Error?) -> ()) {
//        self.session.request(endpoint)
//            .validate()
//            .responseJSON { (response) in
//                let statusCode = response.response?.statusCode
//                switch response.result {
//                case .success(let value):
//                    completion(value, statusCode, nil)
//                case .failure(let error):
//                    completion(nil, statusCode, self.parseApiError(with: statusCode, error: error))
//                }
//        }
//    }
    
    private func parseApiError(with statusCode: Int?, error: AFError) -> Error {
        switch statusCode {
        case 403:
            return ApiError.forbidden
        case 404:
            return ApiError.forbidden
        case 409:
            return ApiError.conflict
        case 500:
            return ApiError.internalServerError
        default:
            return error
        }
    }
    
}
