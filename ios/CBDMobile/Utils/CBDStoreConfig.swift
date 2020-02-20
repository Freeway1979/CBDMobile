//
//  CBDStoreConfig.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CBDStoreConfig {
    
    private(set) var config: Realm.Configuration?
    
    let schemaVersion: UInt64 = 1
    let dbName = "CBDStore.realm"
    
    init() {
        // Generate a random encryption key
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { bytes in
            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        }
        
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                        appropriateFor: nil, create: false)
        let url = documentDirectory.appendingPathComponent(dbName)
        
        config = Realm.Configuration(fileURL: url, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: key, readOnly: false, schemaVersion: schemaVersion, migrationBlock: { (migration, oldSchemaVersion) in
            self.databaseMigration(migration, newVersion: self.schemaVersion, oldVersion: oldSchemaVersion)
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
    }
    
    func customeConfig(_ config: Realm.Configuration) {
        self.config = config
    }
    
    func databaseMigration(_ migration: Migration, newVersion: UInt64, oldVersion: UInt64) {
        if newVersion > oldVersion {
            print("Database need mirgration.")
        } else {
            print("Database not need mirgration.")
        }
    }
}
