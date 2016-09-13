//
//  Entity.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation

open class Entity: Hashable {
    
    open var hashValue: Int {
        get {
            return self.entityId.hashValue
        }
    }
    
    open var entityId: String!
    
    required public  init() {
    }
    
    open class func entityWithId(_ entityId: String) -> Entity {
        return Entity(entityId: entityId)
    }
    
    public init(entityId: String) {
        self.entityId = entityId
    }
    
    open func equals<T>(_ other: T) -> Bool where T: Entity {
        return self.entityId == other.entityId
    }
}

public func ==<T>(lhs: T, rhs: T) -> Bool where T: Entity {
    return lhs.equals(rhs)
}
