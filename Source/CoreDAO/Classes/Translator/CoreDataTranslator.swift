//
//  RealmTranslator.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 06.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import CoreData


open class CoreDataTranslator<CDModel: NSManagedObject, Model: Entity> {
    
    open var entityClass: Model.Type
    {
        return Model.self
    }
    
    open var entryClass: CDModel.Type
    {
        return CDModel.self
    }
    
    open class func translator() -> CoreDataTranslator
    {
        return self.init()
    }
    
    required public init()
    {
        
    }
    
    open func fillEntity(_ entity: Model?, withEntry entry: CDModel) -> Bool
    {
        fatalError("Abstact method")
    }
    
    open func fillEntry(_ entry: CDModel,
                          withEntity entity: Model,
                          inContext context: NSManagedObjectContext) -> Bool
    {
        fatalError("Abstact method")
    }
}
