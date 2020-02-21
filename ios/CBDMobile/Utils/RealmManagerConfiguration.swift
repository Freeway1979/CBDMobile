//
//  RealmManagerConfiguration.swift
//  CBDMobile
//
//  Created by phsong on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmManagerConfiguration {
    
    let schemaVersion: UInt64 = 1
    let dbName = "CBDStore.realm"
    
    func create() throws -> Realm.Configuration {
        guard let documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                                   appropriateFor: nil, create: false) else {
                throw Error.openingFailed
        }
        let url = documentDirectory.appendingPathComponent(dbName)
        
        let encryptionKey = getKeyFromKeychain()
        let realmConfiguration = Realm.Configuration(fileURL: url, encryptionKey: encryptionKey, readOnly: false, schemaVersion: schemaVersion, migrationBlock: { (migration, oldSchemaVersion) in
            self.databaseMigration(migration, oldVersion: oldSchemaVersion)
        })
        
        return realmConfiguration
    }
    
    
    func getKeyFromKeychain() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = [NSObject.self, NSString.self].description
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
        
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData as Data
    }
    
    /// Database mirgration stragey configuraion
    func databaseMigration(_ migration: Migration, oldVersion: UInt64) {
        if schemaVersion > oldVersion {
            print("Database need mirgration.")
        } else {
            print("Database not need mirgration.")
        }
    }
}

extension RealmManagerConfiguration {
    
    enum Error: LocalizedError {
        case openingFailed
        case openingFileURLFailed
        case removingFileProtectionFailed
        
        var errorDescription: String? {
            switch self {
            case .openingFailed:
                return "Failed to open or create the selected Realm."
            case .openingFileURLFailed:
                return "Failed to open the URL path for the Realm folder."
            case .removingFileProtectionFailed:
                return "Failed to remove file protection at the specified path."
            }
        }
    }
}
