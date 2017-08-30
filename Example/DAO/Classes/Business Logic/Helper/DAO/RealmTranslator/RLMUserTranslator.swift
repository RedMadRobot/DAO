//
//  RLMUserTranslator.swift
//  DAO
//
//  Created by Ivan Vavilov on 8/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import DAO

class RLMUserTranslator: RealmTranslator<User, DBUser> {

    required init() {}
    
    
    override func fill(_ entity: User, fromEntry: DBUser) {
        entity.entityId = fromEntry.entryId
        entity.name = fromEntry.name
    }
    
    
    override func fill(_ entry: DBUser, fromEntity: User) {
        if entry.entryId != fromEntity.entityId {
            entry.entryId = fromEntity.entityId
        }
        
        entry.name = fromEntity.name
    }
    
}
