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


open class RLMEntry: Object {
    
    dynamic open var entryId: String
    
    public init(entryId: String)
    {
        self.entryId = entryId
        super.init()
    }
    
    public required init()
    {
        self.entryId = ""
        super.init()
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        self.entryId = ""
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    open class func nullEntry() -> RLMEntry
    {
        let entry = RLMEntry()
        entry.entryId = "0"
        return entry
    }
    
    override open class func primaryKey() -> String?
    {
        return "entryId"
    }
    
}
