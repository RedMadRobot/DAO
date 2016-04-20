//
//  RLMFolderTranslator.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO
import RealmSwift

class RLMFolderTranslator: RealmTranslator<Folder, DBFolder> {
    
    required init() {
        
    }
    
    override func toEntry(entity: Folder) -> DBFolder {
        let folder = entity
        let messageTranslator = RLMMessageTranslator.translator()
        let messages = messageTranslator.toEntries(folder.messages)
        
        return DBFolder.folderWithId(folder.entityId, name: folder.name ?? "", messages: messages )
    }
    
    override func toEntity(entry: DBFolder) -> Folder {
        let messageTranslator = RLMMessageTranslator.translator()
        let messages = messageTranslator.toEntities(entry.messages)
        
        return Folder.folderWithId(entry.entryId, name: entry.name, messages: messages)
    }
}