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
        APIManager.shared().callDecodable(endpoint: SiteEndpoint.readSites) { (result: Result<[Site], Error>) in
            switch result {
            case .success(let sites):
                completion(sites)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getSite(with name: String, completion: @escaping (Site?) -> ()) {
        APIManager.shared().callDecodable(endpoint: SiteEndpoint.readSite(name: name)) { (result: Result<Site, Error>) in
            switch result {
            case .success(let site):
                completion(site)
            case .failure(_):
                completion(nil)
            }
        }
    }

    func createSite(with site: Site, completion: @escaping (Site?) -> ()) {
        guard let parameters = site.alamofireParameters else { return }
        APIManager.shared().callDecodable(endpoint: SiteEndpoint.createSite(parameters: parameters)) { (result: Result<Site, Error>) in
            switch result {
            case .success(let site):
                completion(site)
            case .failure(_):
                completion(nil)
            }
        }
    }

    func updateSite(with name: String, site: Site, completion: @escaping (Site?) -> ()) {
        guard let parameters = site.alamofireParameters else { return }
        APIManager.shared().callDecodable(endpoint: SiteEndpoint.updateSite(name: name, parameters: parameters)) { (result: Result<Site, Error>) in
            switch result {
            case .success(let site):
                completion(site)
            case .failure(_):
                completion(nil)
            }
        }
    }

    func deleteSite(with name: String, completion: @escaping (Error?) -> ()) {
        APIManager.shared().call(endpoint: SiteEndpoint.deleteSite(name: name)) { (error) in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }
    
}

