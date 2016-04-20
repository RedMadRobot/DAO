//
//  DAO.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import Foundation

public class DAO<Model: Entity> {
    
    // MARK: Вставка / Обновление
    public func persist(entity: Model) throws
    {
        preconditionFailure()
    }
    
    public func persistAll(entities: [Model]) throws
    {
        preconditionFailure()
    }
    
    // MARK: Чтение
    
    public func read(entityId: String) -> Model?
    {
        preconditionFailure()
    }
    
    public func readAll() -> [Model]
    {
        preconditionFailure()
    }
    
    public func readAll(predicate predicate: NSPredicate?) -> [Model]
    {
        preconditionFailure()
    }
    
    public func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        preconditionFailure()
    }
    
    public func readAll(predicate predicate: NSPredicate?, orderBy field: String?, ascending: Bool) -> [Model]
    {
        preconditionFailure()
    }
    
    // MARK: Удаление
    
    public func erase() throws
    {
        preconditionFailure()
    }
    
    public func erase(entityId: String) throws
    {
        preconditionFailure()
    }
    
}