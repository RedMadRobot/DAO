//
//  Message.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import CoreDAO


class Message: Entity {

    var text: String?

    init(entityId: String, text: String?)
    {
        self.text = text
        super.init(entityId: entityId)
    }

    required init()
    {
        super.init()
    }

    override func equals<T>(_ other: T) -> Bool where T: Message
    {
        return super.equals(other) && self.text == other.text
    }
}
