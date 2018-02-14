//
//  DBBook.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import DAO
import RealmSwift


final class DBBook: DBEntity {

    @objc dynamic var name: String = ""
    
    let authors = List<String>()
    
    let dates = List<Date>()
    
    let pages = List<Int>()
    
    let attachments = List<Data>()
    
}
