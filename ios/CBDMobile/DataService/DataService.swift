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

enum DataMode {
    case local
    case network
    /// local and network
    case localAndNetwork
    /// local and network if local empty
    case localOrNetwork
}

struct DataOption {
    static let defaultMode = DataMode.localAndNetwork
    var mode = defaultMode
    var url = ""
    var params:[String:Any] = [:]
}

// Should all Data as an Array?
enum ServiceResult<T: Object> {
    case network([T])
    case local([T])
}

// Design- as a protocol or a base class?
class DataService {
    func getData<T: Object>(options: DataOption, completionHandler: @escaping ((Result<ServiceResult<T>, Error>) -> Void)) {
        let mode = options.mode
        if mode == .local || mode == .localAndNetwork {
            retriveDataFromDB(options.params) { (result) in
                switch result {
                case .success(let list):
                    completionHandler(.success(.local(list as! [T])))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
        if mode == .network || mode == .localAndNetwork {
            retriveDataFromNetwork { (data, error) in
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    // Save into local database for further usage
                    completionHandler(.success(.network(data as! [T])))
                }
            }
        }
    }
    
    /// Retrive site only from database
    func retriveDataFromDB<T: Object>(_ params: [String:Any]? = nil, completion: @escaping ((Result<[T], Error>) -> Void))  {
//        let condition:String = "" // Build condition from params
//        RealmManager.shared().retrive(T.self, condition: condition) { (result) in
//            completion(result)
//        }
    }
    
    /// Retrive site only from netwrok
    func retriveDataFromNetwork<T:Object>(completionHandler: ( ([T], Error?) -> Void)) {
        // TODO api request
    }
}
