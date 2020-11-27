//
//  RLMEntry.swift
//  DAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


/// Parent class for `Realm` entries.
open class RLMEntry: Object {
    
    /// Entry identifier. Must be unique.
    @objc dynamic open var entryId: String
    
    
    /// Creates an instance with specified `entryId`.
    ///
    /// - Parameter entryId: entry identifier.
    public init(entryId: String) {
        self.entryId = entryId
        super.init()
    }
    
    
    /// Creates an instance with emppty `entryId`.
    public required override init() {
        self.entryId = ""
        super.init()
    }

    open override class func primaryKey() -> String? {
        return "entryId"
    }
    
}
