//
//  CDEntityTranslator.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 2/9/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO
import CoreData

class CDEntityTranslator: CoreDataTranslator<CDEntity, Entity> {
    
    override func fillEntity(entity: Entity?, withEntry entry: NSManagedObject) -> Bool {
        guard   let coreDataEntity = entity,
                let coreDataEntry = entry as? CDEntity else {
            return false
        }
        
        coreDataEntity.entityId = coreDataEntry.entryId
        
        return true
    }
    
    required init() {
        
    }
    
    override func fillEntry(entry: NSManagedObject, withEntity entity: Entity, inContext context: NSManagedObjectContext) -> Bool {
        guard let coreDataEntry = entry as? CDEntity else {
            return false
        }
        
        coreDataEntry.entryId = entity.entityId
        
        return true
    }
}
