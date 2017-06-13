//
//  DBEntity.swift
//  DAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import DAO


class DBEntity: RLMEntry {

    class func entityWithId(_ entityId: String) -> DBEntity
    {
        let entity = DBEntity()
        entity.entryId = entityId
        return entity
    }
    
    
}
