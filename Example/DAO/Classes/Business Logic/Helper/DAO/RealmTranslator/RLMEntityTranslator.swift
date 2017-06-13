//
//  RealmTranslator.swift
//  DAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import DAO

class RLMEntityTranslator: RealmTranslator<Entity, DBEntity> {
    
    required init() {
        
    }

    
    override func fill(_ entity: Entity, fromEntry: DBEntity) {
        entity.entityId = fromEntry.entryId
    }
    
    
    override func fill(_ entry: DBEntity, fromEntity: Entity) {
        if entry.entryId != fromEntity.entityId {
            entry.entryId = fromEntity.entityId
        }
    }
    
}
