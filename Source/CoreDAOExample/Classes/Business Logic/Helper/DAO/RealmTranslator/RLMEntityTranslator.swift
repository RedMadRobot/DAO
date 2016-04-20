//
//  RealmTranslator.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import CoreDAO

class RLMEntityTranslator: RealmTranslator<Entity, DBEntity> {
    
    required init() {
        
    }

    override func toEntity(entry: DBEntity) -> Entity {
        return Entity.entityWithId(entry.entryId)
    }
    
    override func toEntry(entity: Entity) -> DBEntity {
        return DBEntity.entityWithId(entity.entityId)
    }
}