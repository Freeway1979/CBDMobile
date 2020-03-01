//
//  DataService.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/2/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import Alamofire

enum DataServiceResult<T> {
    case network(T)
    case local(T)
}

/// Type of action
enum DataServiceMode {
    case networkOnly(APIConvertible, Parameters) // only perform on network
    case localOnly // only perform on local
    case localWithNetwork(APIConvertible, Parameters) // perform both local and network
}

// MARK: APPEND

protocol DataServiceAppend {
    associatedtype ObjectType: Object
    func append(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void))
    func appendRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void))
}

extension DataServiceAppend {
    func appendRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void)) {
        
    }
}

extension DataServiceAppend {
    func append(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void)) {
        switch mode {
        case .localOnly:
            appendLocal(object, completion: completion)
        case .networkOnly(let request, let params):
            appendRemote(object, request: request, params: params, completion: completion)
        case .localWithNetwork(let request, let params):
            appendRemote(object, request: request, params: params) { error in
                if error == nil {
                    appendLocal(object, completion: completion)
                } else {
                    completion(error)
                }
            }
        }
    }
    
    private func appendLocal(_ object: ObjectType, completion: ((Error?) -> Void)) {
        RealmManager.shared().addOrUpdate(object: object, condition: nil, completion: completion)
    }
}


// MARK: DELETE

/// Protocol for delete
protocol DataServiceDelete {
    associatedtype ObjectType: Object
    
    func delete(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void))
    
    func deleteRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void))
}

extension DataServiceDelete {
    func deleteRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void)) {
        
    }
}

extension DataServiceDelete {
    func delete(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void)) {
        switch mode {
        case .localOnly:
            deleteLocal(object, completion: completion)
        case .networkOnly(let request, let params):
            deleteRemote(object, request: request, params: params, completion: completion)
        case .localWithNetwork(let request, let params):
            deleteRemote(object, request: request, params: params) { error in
                if error == nil {
                    deleteLocal(object, completion: completion)
                } else {
                    completion(error)
                }
            }
        }
    }
    
    private func deleteLocal(_ object: ObjectType, completion: ((Error?) -> Void)) {
        RealmManager.shared().delete(object: object, completion: completion)
    }
}

// MARK: UPDATE

protocol DataServiceUpdate {
    associatedtype ObjectType: Object
    
    func update(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void))
    
    func updateRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void))
}

extension DataServiceUpdate {
    func updateRemote(_ object: ObjectType, request: APIConvertible, params: Parameters, completion: ((Error?) -> Void)) {
        fatalError("updateRemote(:) has not been implemented")
    }
}

extension DataServiceUpdate {
    func update(_ object: ObjectType, mode: DataServiceMode, completion: ((Error?) -> Void)) {
        switch mode {
        case .localOnly:
            updateLocal(object, completion: completion)
        case .networkOnly(let request, let params):
            updateRemote(object, request: request, params: params, completion: completion)
        case .localWithNetwork(let request, let params):
            updateRemote(object, request: request, params: params) { error in
                if error == nil {
                    updateLocal(object, completion: completion)
                } else {
                    completion(error)
                }
            }
        }
    }
    
    func updateLocal(_ object: ObjectType, completion: ((Error?) -> Void)) {
        RealmManager.shared().addOrUpdate(object: object, condition: nil, completion: completion)
    }
}


// MARK: RETRIVE

protocol DataServiceRetrive {
    associatedtype ObjectType: Object
    func retrive(condition: String?, params: Parameters?, mode: DataServiceMode, completion: ((Result<DataServiceResult<[ObjectType]>, Error>) -> Void))
    
    func retriveRemote(with request: APIConvertible, params: [String: Any], completion: ((Result<DataServiceResult<[ObjectType]>, Error>) -> Void))
}

extension DataServiceRetrive {
    func retriveRemote(with request: APIConvertible, params: Parameters, completion: ((Result<DataServiceResult<[ObjectType]>, Error>) -> Void)) {
        
    }
}

extension DataServiceRetrive {
    func retrive(condition: String? = nil, params: Parameters? = nil, mode: DataServiceMode, completion: ((Result<DataServiceResult<[ObjectType]>, Error>) -> Void)) {
        switch mode {
        case .localOnly:
            retriveLocal(condition: condition) { result in
                switch result {
                case .success(let list):
                    completion(.success(.local(list)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .networkOnly(let request, let params):
            retriveRemote(with: request, params: params, completion: completion)
        case .localWithNetwork(let request, let params):
            retriveLocal(condition: condition) { result in
                switch result {
                case .success(let list):
                    completion(.success(.local(list)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            retriveRemote(with: request, params: params, completion: completion)
        }
    }
    
    private func retriveLocal(condition: String?, completion: ((Result<[ObjectType], Error>) -> Void)) {
        RealmManager.shared().retrive(ObjectType.self, condition: condition, completion: completion)
    }
}
