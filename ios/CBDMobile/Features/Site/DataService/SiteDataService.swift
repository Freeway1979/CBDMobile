//
//  SiteDataService.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

enum SiteServiceResult {
    case network([Site])
    case local([Site])
}

// MARK: Read
class SiteDataService {
    
    static let `default` = SiteDataService()
    
    /// Get site list from local database and network
    func getSiteList(completionHandler: @escaping ((Result<SiteServiceResult, Error>) -> Void)) {
        retriveSitesFromDB { result in
            switch result {
            case .success(let sites):
                completionHandler(.success(.local(sites)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        retriveSiteListFromNetwork { (sites, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                // Save into local database for further usage
                self.appendSites(sites, completion: nil)
                completionHandler(.success(.network(sites)))
            }
        }
    }
    
    /// Retrive site only from database
    func retriveSitesFromDB(_ condition: String? = nil, completion: @escaping ((Result<[Site], Error>) -> Void))  {
        RealmManager.shared().retrive(Site.self, condition: condition) { result in
            completion(result)
        }
    }
    
    /// Retrive site only from netwrok
    func retriveSiteListFromNetwork(completionHandler: ( ([Site], Error?) -> Void)) {
        // TODO api request
    }
    
}

// MARK: Append
extension SiteDataService {
    
    func appendSites(_ sites: [Site], completion: ((Error?) -> Void)?) {
        appendSitesRemote(sites) { error in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
                self.appendSitesIntoDB(sites, completion: nil)
            }
        }
    }
    
    func appendSitesIntoDB(_ sites: [Site], completion: ((Error?) -> Void)?) {
        RealmManager.shared().addOrUpdate(objects: sites) { error in
            completion?(error)
        }
    }
    
    func appendSitesRemote(_ sites: [Site], completion: ((Error?) -> Void)?) {
        // TODO API call
    }
    
}

// MARK: Remove
extension SiteDataService {
    func deleteSite(_ sites: [Site], completion: ((Error?) -> Void)?) {
        RealmManager.shared().delete(objects: sites) { error in
            completion?(error)
        }
    }
    
    func deleteAllSites(completion: ((Error?) -> Void)?) {
        RealmManager.shared().dropTable(type: Site.self) { error in
            completion?(error)
        }
    }
}
