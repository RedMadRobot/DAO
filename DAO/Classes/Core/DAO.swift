//
//  DAO.swift
//  DAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import Foundation


/// Parent class for DAO pattern implemetation (aka interface).
open class DAO<Model: Entity> {
    
    // MARK: - Insert/update
    
    
    /// Saving new entity or update existing.
    ///
    /// - Parameter entity: entity should be saved.
    /// - Throws: error if entity can not be saved.
    open func persist(_ entity: Model) throws {
        preconditionFailure()
    }
    
    
    /// Saving new entities or update existing.
    ///
    /// - Parameter entities: entities should be saved.
    /// - Throws: error if any entity can not be saved.
    open func persist(_ entities: [Model]) throws {
        preconditionFailure()
    }
    
    
    // MARK: - Read
    
    /// Read entity from database of `Model` type.
    ///
    /// - Parameter entityId: entity identifier.
    /// - Returns: instance of existant entity or nil.
    open func read(_ entityId: String) -> Model? {
        preconditionFailure()
    }
    
    
    /// Read all entities from database of `Model` type.
    ///
    /// - Returns: array of entities.
    open func read() -> [Model] {
        preconditionFailure()
    }
    
    
    /// Read all entities from database of `Model` type filtered by predicate.
    ///
    /// - Parameter predicate: predicate to filter entities.
    /// - Returns: filtered array of entities.
    open func read(predicatedBy predicate: NSPredicate?) -> [Model] {
        preconditionFailure()
    }
    
    
    /// Read all entities from database of `Model` type ordered by field.
    ///
    /// - Parameters:
    ///   - field: ordering field.
    ///   - ascending: ascending flag (descending otherwise).
    /// - Returns: ordered array of entities.
    open func read(orderedBy field: String?, ascending: Bool) -> [Model] {
        preconditionFailure()
    }
    
    
    /// Read all entities from database of `Model` type filtered by predicate and ordered by field.
    ///
    /// - Parameters:
    ///   - predicate: predicate to filter entities.
    ///   - field: ordering field.
    ///   - ascending: ascending flag (descending otherwise).
    /// - Returns: filtered and ordered array of entities.
    open func read(predicatedBy predicate: NSPredicate?, orderedBy field: String?,
                   ascending: Bool) -> [Model] {
        preconditionFailure()
    }
    
    
    // MARK: - Delete
    
    /// Delete all entities of `Model` type.
    ///
    /// - Throws: error if any entity can not be deleted.
    open func erase() throws {
        preconditionFailure()
    }
    
    
    /// Delete entity of `Model` type by identifier.
    ///
    /// - Throws: error if any entity can not be deleted.
    open func erase(_ entityId: String) throws {
        preconditionFailure()
    }
    
}
