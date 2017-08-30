//
//  DBUser.swift
//  DAO
//
//  Created by Ivan Vavilov on 8/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class DBUser: DBEntity {

    dynamic var name: String = ""
    
    
    class func userWithId(_ entryId: String, name: String) -> DBUser {
        let user = DBUser()
        user.entryId = entryId
        user.name = name
        return user
    }
    
}
