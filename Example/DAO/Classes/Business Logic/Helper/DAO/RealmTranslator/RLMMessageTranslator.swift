//
//  RLMMessageTranslator.swift
//  DAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import DAO

class RLMMessageTranslator: RealmTranslator<Message, DBMessage> {
    
    required init() {
        
    }
    
    override func fill(_ entity: Message, fromEntry: DBMessage) {
        entity.entityId = fromEntry.entryId
        entity.text = fromEntry.text
    }
    
    
    override func fill(_ entry: DBMessage, fromEntity: Message) {
        if entry.entryId != fromEntity.entityId {
            entry.entryId = fromEntity.entityId
        }
        entry.text = fromEntity.text
    }

}
