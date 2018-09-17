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
    
    /// URL of database.
    public let databaseURL: URL?
    
    /// Migration block for manual migration.
    public let migrationBlock: MigrationBlock?
    
    /// Key to encrypt data.
    public let encryptionKey: Data?
    
    /**
     A block called when opening a Realm for the first time during the life
     of a process to determine if it should be compacted before being returned
     to the user. It is passed the total file size (data + free space) and the total
     bytes used by data in the file.
     
     Return `true` to indicate that an attempt to compact the file should be made.
     The compaction will be skipped if another process is accessing it.
     */
    public let shouldCompactOnLaunch: ((Int, Int) -> Bool)?
    
    
    /// Create an instance with specified `databaseFileName`, `dataBaseURL`, `databaseVersion`, `migrationBlock`.
    ///
    /// - Parameters:
    ///   - databaseFileName: name. See above.
    ///   - databaseURL: url. See above.
    ///   - databaseVersion: version. See above.
    ///   - migrationBlock: migration block. See above.
    ///   - encryptionKey: encryption key. See above.
    public init(
        databaseFileName: String = "Database.realm",
        databaseURL: URL? = nil,
        databaseVersion: UInt64 = 1,
        migrationBlock: MigrationBlock? = nil,
        encryptionKey: Data? = nil,
        shouldCompactOnLaunch: ((Int, Int) -> Bool)? = nil) {
        
        self.databaseFileName = databaseFileName
        self.databaseURL = databaseURL
        self.databaseVersion = databaseVersion
        self.migrationBlock = migrationBlock
        self.encryptionKey = encryptionKey
        self.shouldCompactOnLaunch = shouldCompactOnLaunch
    }
    
}
