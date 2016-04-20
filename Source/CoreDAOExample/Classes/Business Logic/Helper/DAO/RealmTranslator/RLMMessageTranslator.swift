//
//  RLMMessageTranslator.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO

class RLMMessageTranslator: RealmTranslator<Message, DBMessage> {
    
    required init() {
        
    }
    
    
    override func toEntity(entry: DBMessage) -> Message {
        return Message(entityId:entry.entryId, text: entry.text)
    }
    
    override func toEntry(entity: Message) -> DBMessage {
        return DBMessage.messageWithId(entity.entityId, text: entity.text)
    }
}