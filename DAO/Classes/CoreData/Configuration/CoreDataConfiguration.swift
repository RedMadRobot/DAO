//
//  CoreDataConfiguration.swift
//  DAO
//
//  Created by Ivan Vavilov on 12/05/2017.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import Foundation
import CoreData


/// `CoreData DAO` configuration.
/// Incapsulates basic settings.
/// Used to initialize `CoreData DAO`.
public struct CoreDataConfiguration {
    
    /// Name of container also is filename for `*.xcdatamodelid` file.
    public let containerName: String
    
    /// Store type like in `CoreData`. `NSInMemoryStoreType`, for instance.
    public let storeType: String
    
    /// Options for persistence store
    public let options: [String: NSObject]
    
    
    /// Create an instance with specified `containerName`, `storeType`, `options`.
    ///
    /// - Parameters:
    ///   - containerName: name. See above.
    ///   - storeType: store type. See above.
    ///   - options: persistence store options.
    public init(
        containerName: String,
        storeType: String = NSSQLiteStoreType,
        options: [String : NSObject] =
            [NSMigratePersistentStoresAutomaticallyOption: true as NSObject,
             NSInferMappingModelAutomaticallyOption: true as NSObject]) {
        self.containerName = containerName
        self.storeType = storeType
        self.options = options
    }
    
}
