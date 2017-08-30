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
    var creator: User?
    var messages = [Message]()
    
    
    init(entityId: String, name: String, creator: User? = nil, messages: [Message]) {
        self.name = name
        self.creator = creator
        self.messages = messages
        
        super.init(entityId: entityId)
    }
    
    
    required init() {
        super.init()
    }
    
    
    override func equals<T>(_ other: T) -> Bool where T : Folder {
        return (super.equals(other)) && self.name == other.name && self.messagesArrayEquals(other.messages)
    }
    
    
    fileprivate func messagesArrayEquals(_ otherMessages: [Message]) -> Bool {
        if (self.messages.count != otherMessages.count) { return false }
        
        for message in otherMessages {
            if (!messages.contains(message)) { return false }
        }
        return true
    }
}
