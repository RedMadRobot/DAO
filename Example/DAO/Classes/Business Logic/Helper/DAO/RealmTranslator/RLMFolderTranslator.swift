//
//  RLMFolderTranslator.swift
//  DAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import DAO
import RealmSwift

class RLMFolderTranslator: RealmTranslator<Folder, DBFolder> {
    
    required init() {}
    
    
    override func fill(_ entity: Folder, fromEntry: DBFolder) {
        entity.entityId = fromEntry.entryId
        entity.name = fromEntry.name
        
        RLMMessageTranslator().fill(&entity.messages, fromEntries: fromEntry.messages)
    }
    
    
    override func fill(_ entry: DBFolder, fromEntity: Folder) {
        if entry.entryId != fromEntity.entityId {
            entry.entryId = fromEntity.entityId
        }
        entry.name = fromEntity.name
        
        RLMMessageTranslator().fill(entry.messages, fromEntities: fromEntity.messages)
    }
    
}
