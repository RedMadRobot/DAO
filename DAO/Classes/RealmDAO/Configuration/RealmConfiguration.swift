//
// Created by Ivan Vavilov on 5/22/17.
// Copyright (c) 2017 RedMadRobot LLC. All rights reserved.
//

import Foundation
import RealmSwift

/// `Realm DAO` configuration.
/// Incapsulates basic settings.
/// Used to initialize `Realm DAO`.
public struct RealmConfiguration {

    /// Name of database file name.
    public let databaseFileName: String
    
    /// Version of database.
    public let databaseVersion: UInt64
    
    /// Migration block for manual migration.
    public let migrationBlock: MigrationBlock?
    
    /// Key to encrypt data.
    public let encryptionKey: Data?
    
    
    /// Create an instance with specified `databaseFileName`, `databaseVersion`, `migrationBlock`.
    ///
    /// - Parameters:
    ///   - databaseFileName: name. See above.
    ///   - databaseVersion: version. See above.
    ///   - migrationBlock: migration block. See above.
    ///   - encryptionKey: encryption key. See above.
    public init(
        databaseFileName: String = "Database.realm",
        databaseVersion: UInt64 = 1,
        migrationBlock: MigrationBlock? = nil,
        encryptionKey: Data? = nil) {
        
        self.databaseFileName = databaseFileName
        self.databaseVersion = databaseVersion
        self.migrationBlock = migrationBlock
        self.encryptionKey = encryptionKey
    }
    
}
