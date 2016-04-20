//
//  DBEntity.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO


class DBEntity: RLMEntry {

    class func entityWithId(entityId: String) -> DBEntity
    {
        let entity = DBEntity()
        entity.entryId = entityId
        return entity
    }
}