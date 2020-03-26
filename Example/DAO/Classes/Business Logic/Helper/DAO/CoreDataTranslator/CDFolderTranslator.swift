//
//  CDFolderTranslator.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/2/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import DAO
import CoreData


class CDFolderTranslator: CoreDataTranslator<Folder, CDFolder> {

    required init() {}

    
    override func fill(_ entity: Folder, fromEntry entry: CDFolder) {
        entity.entityId = entry.entryId
        entity.name = entry.name
        
        CDMessageTranslator().fill(&entity.messages, fromEntries: entry.messages as? Set<CDMessage>)
    }

    
    override func fill(
            _ entry: CDFolder,
            fromEntity entity: Folder,
            in context: NSManagedObjectContext) {
        entry.entryId = entity.entityId
        entry.name = entity.name
        
        var messages = Set<CDMessage>()
        CDMessageTranslator().fill(&messages, fromEntities: entity.messages, in: context)
        
        if let m = entry.messages {
            entry.removeFromMessages(m)
        }
        
        entry.addToMessages(messages as NSSet)
    }

}
