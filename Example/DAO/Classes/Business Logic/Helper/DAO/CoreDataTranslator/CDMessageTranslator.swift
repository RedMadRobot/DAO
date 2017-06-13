//
//  CDMessageTranslator.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/2/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import DAO
import CoreData


class CDMessageTranslator: CoreDataTranslator<CDMessage, Message> {

    override func fill(_ entity: Message?, fromEntry entry: CDMessage) {
        entity?.entityId = entry.entryId
        entity?.text = entry.text
    }


    required init() {}


    override func fill(
            _ entry: CDMessage,
            fromEntity entity: Message,
            in context: NSManagedObjectContext) {
        entry.entryId = entity.entityId
        entry.text = entity.text
    }

}
