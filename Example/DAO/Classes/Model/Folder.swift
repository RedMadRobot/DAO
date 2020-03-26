//
//  Folder.swift
//  DAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import DAO


class Folder: Entity {
    
    var name: String = ""
    var messages = [Message]()
    
    
    init(entityId: String, name: String, messages: [Message]) {
        self.name = name
        self.messages = messages
        
        super.init(entityId: entityId)
    }
    
    
    required init() {
        super.init()
    }
    
    override func equals<T>(_ other: T) -> Bool where T : Entity {
        guard let other = other as? Folder else { return false }
        return super.equals(other) && name == other.name && messagesArrayEquals(other.messages)
    }
    
    fileprivate func messagesArrayEquals(_ otherMessages: [Message]) -> Bool {
        if messages.count != otherMessages.count { return false }
        
        for message in otherMessages {
            if !messages.contains(message) { return false }
        }
        return true
    }
}
