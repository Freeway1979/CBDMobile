//
//  SiteInteractor.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/21.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

final class SiteInteractor {
    
    func getSites(completion: @escaping ([Site]?) -> ()) {
        APIManager.shared().call(endpoint: SiteEndpoint.readSites) { (sites: [Site]?, statusCode, error) in
            guard let sites = sites else {
                completion(nil)
                return
            }
            completion(sites)
        }
    }
    
    func getSite(with name: String, completion: @escaping (Site?) -> ()) {
        APIManager.shared().call(endpoint: SiteEndpoint.readSite(name: name)) { (site: Site?, statusCode, error) in
            guard let site = site else {
                completion(nil)
                return
            }
            completion(site)
        }
    }
    
    func createSite(with site: Site, completion: @escaping (Site?) -> ()) {
        guard let parameters = site.alamofireParameters else { return }
        APIManager.shared().call(endpoint: SiteEndpoint.createSite(parameters: parameters)) { (site: Site?, statusCode, error) in
            guard let site = site else {
                completion(nil)
                return
            }
            completion(site)
        }
    }
    
    func updateSite(with name: String, site: Site, completion: @escaping (Site?) -> ()) {
        guard let parameters = site.alamofireParameters else { return }
        APIManager.shared().call(endpoint: SiteEndpoint.updateSite(name: name, parameters: parameters)) { (site: Site?, statusCode, error) in
            guard let site = site else {
                completion(nil)
                return
            }
            completion(site)
        }
    }
    
    func deleteSite(with name: String, completion: @escaping (()?) -> ()) {
        APIManager.shared().call(endpoint: SiteEndpoint.deleteSite(name:  name)) { (success, statusCode, error) in
            guard let success = success else {
                completion(nil)
                return
            }
            completion(success)
        }
    }
}

