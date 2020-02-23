//
//  RealmManager.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/19.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmManager {
    
    let realmConfiguration: Realm.Configuration?
    var realm: Realm?
    
    private static let sharedManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    
    /// Singleton instance for `RealmManager`
    class func shared() -> RealmManager {
        return sharedManager
    }
    
    init() {
        realmConfiguration = RealmManagerConfiguration().create()
        if let config = realmConfiguration {
            self.realm = try? Realm(configuration: config)
        } else {
            self.realm = try? Realm()
        }
    }
}

extension RealmManager {
    /// Add or Update existed `Object` collection
    private func addOrUpdate<T: Collection>(with realm: Realm, objects: T, completion: ((RealmManagerError?) -> Void)) where T.Element == Object {
        do {
            try realm.write {
                realm.add(objects, update: .error)
                completion(nil)
            }
        } catch let error {
            completion(.writingFailed(error))
        }
    }
    
    /// Add or Update existed `Object` item
    private func addOrUpdate<T: Object>(with realm: Realm, object: T, completion: ((RealmManagerError?) -> Void)) {
        do {
            try realm.write {
                realm.add(object, update: .error)
                completion(nil)
            }
        } catch let error {
            completion(.writingFailed(error))
        }
    }
    
    /// Delte existing `Object` collection records
    private func delete<T: Collection>(with realm: Realm, objects: T, completion: ((RealmManagerError?) -> Void)) where T.Element == Object {
        do {
            try realm.write {
                realm.delete(objects)
                completion(nil)
            }
        } catch let error {
            completion(.writingFailed(error))
        }
    }
    
    /// Clean all records in database
    private func cleanDB(with realm: Realm, completion: ((RealmManagerError?) -> Void)) {
        do {
            try realm.write {
                realm.deleteAll()
                completion(nil)
            }
        } catch let error {
            completion(.writingFailed(error))
        }
    }
    
    /// Write block, used when you want to update `Object` instance
    private func write(with realm: Realm, transaction: (() -> Void)) -> RealmManagerError? {
        do {
            try realm.write {
                transaction()
            }
        } catch let error {
            return .writingFailed(error)
        }
        return nil
    }
}

extension RealmManager {
    
    /// Query `Object` record in database, filter condition paramter optionally
    func retrive<T: Object>(_ condition: String? = nil, completion: ((Result<[T], Error>) -> Void)) {
        guard let realm = realm else {
            completion(.failure(RealmManagerError.realmOpeningFailed))
            return
        }
        
        // All object inside the model passed.
        var objectList = realm.objects(T.self)
        
        if let condition = condition {
            // filters the result if condition exists
            objectList = objectList.filter(condition)
        }
        completion(
            .success(objectList.map { $0 })
        )
    }
}

// MARK: Collection
extension RealmManager {
    
    func addOrUpdate<T: Collection>(objects: T, completion: ((Error?) -> Void)) where T.Element == Object {
        guard let realm = self.realm else {
            completion(RealmManagerError.realmOpeningFailed)
            return
        }
        self.addOrUpdate(with: realm, objects: objects, completion: completion)
    }
    
    func delete<T: Collection>(objects: T, completion: ((Error?) -> Void)) where T.Element == Object {
        guard let realm = self.realm else {
            completion(RealmManagerError.realmOpeningFailed)
            return
        }
        self.delete(with: realm, objects: objects, completion: completion)
    }
}

// MARK: Object
extension RealmManager {
    func addOrUpdate<T: Object>(_condition: String?, object: T, completion: ((Error?) -> Void)) {
        guard let realm = realm else {
            completion(RealmManagerError.realmOpeningFailed)
            return
        }
        self.addOrUpdate(with: realm, object: object, completion: completion)
    }
    
    func delete<T: Object>(object: T, completion: ((Error?) -> Void)) {
        guard let realm = self.realm else {
            completion(RealmManagerError.realmOpeningFailed)
            return
        }
        self.delete(with: realm, objects: [object], completion: completion)
    }
}

// MARK: Remove
extension RealmManager {
    
    /// Clean all records database
    public func cleanDB(completion: ((Error?) -> Void)) {
        guard let realm = realm else {
            completion(RealmManagerError.realmOpeningFailed)
            return
        }
        self.cleanDB(with: realm, completion: completion)
    }
}

extension RealmManager {
    enum RealmManagerError: LocalizedError {
        case realmOpeningFailed
        case writingFailed(Error)
        
        var errorDescription: String? {
            switch self {
            case .realmOpeningFailed:
                return "Failed to get the Realm with the given type."
            case .writingFailed:
                return "The writing transaction on the Realm failed."
            }
        }
    }
}
