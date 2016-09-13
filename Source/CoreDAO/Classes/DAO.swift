//
//  DAO.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import Foundation

open class DAO<Model: Entity> {
    
    // MARK: Вставка / Обновление
    open func persist(_ entity: Model) throws
    {
        preconditionFailure()
    }
    
    open func persistAll(_ entities: [Model]) throws
    {
        preconditionFailure()
    }
    
    // MARK: Чтение
    
    open func read(_ entityId: String) -> Model?
    {
        preconditionFailure()
    }
    
    open func readAll() -> [Model]
    {
        preconditionFailure()
    }
    
    open func readAll(predicate: NSPredicate?) -> [Model]
    {
        preconditionFailure()
    }
    
    open func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        preconditionFailure()
    }
    
    open func readAll(predicate: NSPredicate?, orderBy field: String?, ascending: Bool) -> [Model]
    {
        preconditionFailure()
    }
    
    // MARK: Удаление
    
    open func erase() throws
    {
        preconditionFailure()
    }
    
    open func erase(_ entityId: String) throws
    {
        preconditionFailure()
    }
    
}
