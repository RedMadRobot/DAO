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
        entity.authors = fromEntry.authors.map { $0.value }
        entity.dates = fromEntry.dates.map { $0.value }
        entity.pages = fromEntry.pages.map { $0.value }
        entity.attachments = fromEntry.attachments.map { $0.value }
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
        
        let authors = fromEntity.authors.map { RLMString(val: $0) }
        let dates = fromEntity.dates.map { RLMDate(val: $0) }
        let pages = fromEntity.pages.map { RLMInteger(val: $0) }
        let attachments = fromEntity.attachments.map { RLMData(val: $0) }
        
        entry.authors.append(objectsIn: authors)
        entry.dates.append(objectsIn: dates)
        entry.pages.append(objectsIn: pages)
        entry.attachments.append(objectsIn: attachments)
    }
    
}
