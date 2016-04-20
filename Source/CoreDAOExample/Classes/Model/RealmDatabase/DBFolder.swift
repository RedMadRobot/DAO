//
//  DBFolder.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO
import RealmSwift

class DBFolder: DBEntity {
    
    dynamic var name: String = ""
    let messages = List<DBMessage>()
    
    
    class func folderWithId(entryId: String, name: String, messages: List<DBMessage>) -> DBFolder {
        let folder = DBFolder()
        folder.entryId = entryId
        folder.name = name
        folder.messages.appendContentsOf(messages)
        return folder
    }
}