//
//  DBBook.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import DAO
import RealmSwift


final class DBBook: DBEntity, CascadeDeletionProtocol {

    dynamic var name: String = ""
    
    let authors = List<RLMString>()
    
    let dates = List<RLMDate>()
    
    let pages = List<RLMInteger>()
    
    let attachments = List<RLMData>()
    
    var objectsToDelete: [Object] {
        let authors = Array(self.authors) as [Object]
        let dates = Array(self.dates) as [Object]
        let pages = Array(self.pages) as [Object]
        let attachments = Array(self.attachments) as [Object]
        
        return authors + dates + pages + attachments
    }
    
}
