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
        let apiManager = APIManager(session: Session(eventMonitors: [APILogger()]))
        return apiManager
    }()
    
    static func shared() -> APIManager {
        return shardApiManager
    }
    
    private init(session: Session) {
        self.session = session
    }
    
}

extension APIManager {
    
    @discardableResult
    func callDecodable<T: Decodable>(endpoint: APIConvertible, completion: @escaping (Result<T, Error>) -> ()) -> DataRequest {
        let request = self.session.request(endpoint)
        request
            .validate()
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    completion(.failure(self.parseApiError(with: statusCode, error: error)))
                }
        }
        return request
    }
    
    @discardableResult
    func callJSON(endpoint: APIConvertible, completion: @escaping (Result<Any, Error>) -> ()) -> DataRequest {
        let request = self.session.request(endpoint)
        request
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    completion(.success(json))
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    completion(.failure(self.parseApiError(with: statusCode, error: error)))
                }
        }
        return request
    }
    
    @discardableResult
    func call(endpoint: APIConvertible, completion: @escaping (Error?) -> ()) -> DataRequest {
        let request = self.session.request(endpoint)
        request
            .validate()
            .response { (response) in
                switch response.result {
                case .success(_):
                    completion(nil)
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    completion(self.parseApiError(with: statusCode, error: error))
                    
                }
        }
        return request
    }
    
    private func parseApiError(with statusCode: Int?, error: AFError) -> Error {
        switch statusCode {
        case 403:
            return APIError.forbidden
        case 404:
            return APIError.notFound
        case 409:
            return APIError.conflict
        case 500:
            return APIError.internalServerError
        default:
            return error
        }
    }
    
}

extension APIManager {
    
    /// cancel all request in APIManager session
    /// - Parameter completion: Closure to be called when all `Request`s have been cancelled.
    func cancelAllRequest(completion: (() -> Void)? = nil) {
        self.session.cancelAllRequests(completion: completion)
    }
    
}
