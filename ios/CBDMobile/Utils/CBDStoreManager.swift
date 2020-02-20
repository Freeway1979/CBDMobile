//
//  CBDStoreManager.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/19.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CBDStoreManager {
    
    private static let sharedManager: CBDStoreManager = {
        let manager = CBDStoreManager()
        return manager
    }()
    
    class func shared() -> CBDStoreManager {
        return sharedManager
    }
    
    var realm: Realm? {
        get {
            if let config = CBDStoreConfig().config {
                do {
                    let realm = try Realm(configuration: config)
                    return realm
                } catch let error {
                    print("Realm init fail: \(error.localizedDescription)")
                }
            }
            return nil
        }
    }
    
    func write<T: Object>(_ objs: [T]) {
        assert(objs.count > 0, "Object that need to save must at lease have one item.")
        
        do {
            try realm?.write {
                realm?.add(objs)
            }
        } catch let error {
            print("Failed to write: \(error.localizedDescription)")
        }
    }
    
    func writeAsync<T: Object>(_ objs: [T]) {
        assert(objs.count > 0, "Object that need to save must at lease have one item.")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            autoreleasepool {
                self.realm?.beginWrite()
                objs.forEach { self.realm?.add($0) }
                try! self.realm?.commitWrite()
            }
        }
    }
    
    public func update(_ transaction: (() -> Void)) {
        do {
            realm?.beginWrite()
            transaction()
            try realm?.commitWrite()
        } catch let err as NSError {
            print("Failed to update transaction: \(err.description)")
        }
    }
    
    public func query<T: Object>(_ type: T.Type, filter: NSPredicate? = nil) -> [T] {
        guard let realm = realm else { return [] }
        var results = realm.objects(type)
        if let filter = filter {
            results = results.filter(filter)
        }
        return results.map { $0 }
    }
    
    
    public func delete<T: Object>(_ objs: [T]) {
        assert(objs.count > 0, "Object that need to delete must at lease have one item.")
        
        do {
            try realm?.write {
                realm?.delete(objs)
            }
        } catch let error {
            print("Failed to delete: \(error.localizedDescription)")
        }
    }
    
    public func cleanDB() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error {
            print("Failed to clean db: \(error.localizedDescription)")
        }
    }
}
