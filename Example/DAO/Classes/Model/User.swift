//
//  User.swift
//  DAO
//
//  Created by Ivan Vavilov on 8/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import DAO

class User: Entity {

    var name: String = ""
    
    init(entityId: String, name: String) {
        self.name = name
        
        super.init(entityId: entityId)
    }
    
    
    required init() {
        super.init()
    }
 
    
    override func equals<T>(_ other: T) -> Bool where T : User {
        return super.equals(other) && self.name == other.name
    }
    
}
