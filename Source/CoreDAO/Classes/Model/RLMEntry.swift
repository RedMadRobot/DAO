//
//  RLMEntry.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift
import Realm


public class RLMEntry: Object {
    
    dynamic public var entryId: String
    
    public init(entryId: String)
    {
        self.entryId = entryId
        super.init()
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        self.entryId = ""
        super.init(realm: realm, schema: schema)
    }
    
    public required init()
    {
        self.entryId = ""
        super.init()
    }
    
    public required init(value: AnyObject, schema: RLMSchema)
    {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public class func nullEntry() -> RLMEntry
    {
        let entry = RLMEntry()
        entry.entryId = "0"
        return entry
    }
    
    override public class func primaryKey() -> String?
    {
        return "entryId"
    }
    
}