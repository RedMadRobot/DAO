//
//  RLMBookTranslator.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import UIKit
import DAO

class RLMBookTranslator: RealmTranslator<Book, DBBook> {

    required init() {}
    
    
    override func fill(_ entity: Book, fromEntry: DBBook) {
        entity.entityId = fromEntry.entryId
        entity.name = fromEntry.name
        entity.authors = fromEntry.authors.map { $0 }
        entity.dates = fromEntry.dates.map { $0 }
        entity.pages = fromEntry.pages.map { $0 }
        entity.attachments = fromEntry.attachments.map { $0 }
    }
    
    
    override func fill(_ entry: DBBook, fromEntity: Book) {
        if entry.entryId != fromEntity.entityId {
            entry.entryId = fromEntity.entityId
        }
        
        entry.name = fromEntity.name
        
        entry.authors.removeAll()
        entry.dates.removeAll()
        entry.pages.removeAll()
        entry.attachments.removeAll()
        
        entry.authors.append(objectsIn: fromEntity.authors)
        entry.dates.append(objectsIn: fromEntity.dates)
        entry.pages.append(objectsIn: fromEntity.pages)
        entry.attachments.append(objectsIn: fromEntity.attachments)
    }
    
}
