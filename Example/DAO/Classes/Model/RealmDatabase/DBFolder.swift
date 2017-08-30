//
//  DBFolder.swift
//  DAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import DAO
import RealmSwift

class DBFolder: DBEntity, CascadeDeletionProtocol {
    
    dynamic var name: String = ""
    dynamic var creator: DBUser?
    var messages = List<DBMessage>()
    
    
    class func folderWithId(_ entryId: String, name: String, creator: DBUser? = nil, messages: List<DBMessage>) -> DBFolder {
        let folder = DBFolder()
        folder.entryId = entryId
        folder.name = name
        folder.creator = creator
        folder.messages.append(objectsIn: messages)
        return folder
    }
    
    var objectsToDelete: [Object] {
        return Array(messages)
    }
}
