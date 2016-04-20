//
//  Folder.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import CoreDAO


class Folder: Entity {
    
    var name: String?
    var messages: [Message]?
    
    class func folderWithId(entityId: String, name: String, messages: [Message]?) -> Folder {
        let folder = Folder(entityId: entityId)
        folder.name = name
        folder.messages = messages
        return folder
    }
    
    override func equals<T where T : Folder>(other: T) -> Bool {
        return (super.equals(other)) && self.name == other.name && self.messagesArrayEquals(other.messages)
    }
    
    private func messagesArrayEquals(otherMessages: [Message]?) -> Bool {
        if (self.messages?.count != otherMessages?.count) { return false }
        guard let messages = self.messages,
            let otherMessages = otherMessages else { return false }
        
        for message in otherMessages {
            if (!messages.contains(message)) { return false }
        }
        return true
    }
}