//
//  RealmTranslator.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


open class RealmTranslator<Model: Entity, RealmModel: Object> {
    
    public required init()
    {
        // MARK: ничего не делать
    }
    
    open var entryClassName: RealmModel.Type
    {
        get {
            return RealmModel.self
        }
    }
    
    open func toEntry(_ entity: Model) -> RealmModel
    {
        fatalError("Abstract method")
    }
    
    open func toEntity(_ entry: RealmModel) -> Model
    {
        fatalError("Abstract method")
    }
    
    open func toEntries(_ entities: [Model]?) -> List<RealmModel>
    {
        let list = List<RealmModel>()
        guard let entities = entities else { return list }
        list.append(objectsIn: entities.map { entity in self.toEntry(entity) })
        return list
    }
    
    open func toEntities(_ entries: List<RealmModel>) -> [Model]
    {
        let entities: [Model] = entries.map { entry in self.toEntity(entry) }
        return entities
    }
    
}
