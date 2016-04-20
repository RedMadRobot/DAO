//
//  Entity.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 05.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation

public class Entity: Equatable {
    
    public var entityId: String!
    
    required public  init() {
    }
    
    public class func entityWithId(entityId: String) -> Entity {
        return Entity(entityId: entityId)
    }
    
    public init(entityId: String) {
        self.entityId = entityId
    }
    
    func hash() -> String {
        return String(self.entityId.hash)
    }
    
    public func equals<T where T: Entity>(other: T) -> Bool {
        return self.entityId == other.entityId
    }
}

public func ==<T where T: Entity>(lhs: T, rhs: T) -> Bool {
    return lhs.equals(rhs)
}