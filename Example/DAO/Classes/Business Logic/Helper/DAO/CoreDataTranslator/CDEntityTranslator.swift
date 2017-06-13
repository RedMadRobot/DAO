//
//  CDEntityTranslator.swift
//  DAO
//
//  Created by Ivan Vavilov on 2/9/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import DAO
import CoreData

class CDEntityTranslator: CoreDataTranslator<CDEntity, Entity> {
    
    override func fill(_ entity: Entity, fromEntry: CDEntity) {
        entity.entityId = fromEntry.entryId
    }
    
    required init() {
        
    }
    
    override func fill(
        _ entry: CDEntity,
        fromEntity entity: Entity,
        in context: NSManagedObjectContext) {
        entry.entryId = entity.entityId
    }
}
