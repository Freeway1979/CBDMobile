//
//  TestInteractor.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/24.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

final class TestInteractor {
    func getUserRepos(with name: String, completion: @escaping (Any?) -> ()) {
        APIManager.shared().callJSON(endpoint: TestEndpoint.readUserRepos(name: name)) { result in
            switch result {
            case .success(let repos):
                completion(repos)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
