//
//  RealmTranslator.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 06.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import CoreData


public class CoreDataTranslator<CDModel: NSManagedObject, Model: Entity> {
    
    public var entityClass: Model.Type
    {
        return Model.self
    }
    
    public var entryClass: CDModel.Type
    {
        return CDModel.self
    }
    
    public class func translator() -> CoreDataTranslator
    {
        return self.init()
    }
    
    required public init()
    {
        
    }
    
    public func fillEntity(entity: Model?, withEntry entry: CDModel) -> Bool
    {
        fatalError("Abstact method")
    }
    
    public func fillEntry(entry: CDModel,
                          withEntity entity: Model,
                          inContext context: NSManagedObjectContext) -> Bool
    {
        fatalError("Abstact method")
    }
}