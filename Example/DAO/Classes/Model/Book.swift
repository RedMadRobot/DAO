//
//  Book.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import UIKit
import DAO


class Book: Entity {
    
    var name: String
    
    var authors: [String]
    
    var dates: [Date]
    
    var pages: [Int]
    
    var attachments: [Data]
    
    
    init(entityId: String, name: String, authors: [String], dates: [Date], pages: [Int], attachments: [Data]) {
        self.name = name
        self.authors = authors
        self.dates = dates
        self.pages = pages
        self.attachments = attachments
        
        super.init(entityId: entityId)
    }
    
    
    required init() {
        self.name = ""
        self.authors = []
        self.dates = []
        self.pages = []
        self.attachments = []
        
        super.init()
    }
    
}
