//
//  RealmTranslator.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


public class RealmTranslator<Model: Entity, RealmModel: Object> {
    
    public required init()
    {
        // MARK: ничего не делать
    }
    
    public var entryClassName: RealmModel.Type
    {
        get {
            return RealmModel.self
        }
    }
    
    public func toEntry(entity: Model) -> RealmModel
    {
        fatalError("Abstract method")
    }
    
    public func toEntity(entry: RealmModel) -> Model
    {
        fatalError("Abstract method")
    }
    
    public func toEntries(entities: [Model]?) -> List<RealmModel>
    {
        let list = List<RealmModel>()
        guard let entities = entities else { return list }
        list.appendContentsOf(entities.map { entity in self.toEntry(entity) })
        return list
    }
    
    public func toEntities(entries: List<RealmModel>) -> [Model]
    {
        let entities: [Model] = entries.map { entry in self.toEntity(entry) }
        return entities
    }
    
}