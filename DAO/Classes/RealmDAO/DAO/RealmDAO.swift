//
//  RealmDAO.swift
//  DAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import Realm
import RealmSwift

/// `DAO` pattern implementation for `Realm`.
open class RealmDAO<Model: Entity, RealmModel: RLMEntry>: DAO<Model> {
    
    // MARK: - Private
    
    /// Translator for current `RLMEntry` and `RealmModel` types.
    private let translator: RealmTranslator<Model, RealmModel>
    private let configuration: Realm.Configuration
    
    
    // MARK: - Public
    
    /// Creates an instance with specified `translator` and `configuration`.
    ///
    /// - Parameters:
    ///   - translator: translator for current `Model` and `RealmModel` types.
    ///   - configuration: configuration. See also `RealmConfiguration`.
    public init(
        _ translator: RealmTranslator<Model, RealmModel>,
        configuration: Realm.Configuration) {
        
        self.translator = translator
        self.configuration = configuration
        super.init()
    }
    
    
    /// Creates an instance with specified `translator` and default configuration.
    ///
    /// - Parameters:
    ///   - translator: translator for current `Model` and `RealmModel` types.
    public convenience init(
        _ translator: RealmTranslator<Model, RealmModel>) {

        self.init(translator, configuration: Realm.Configuration.defaultConfiguration)
    }
    
    public static func pathForFileName(_ fileName: String) -> URL? {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first as NSString?
        
        guard let realmPath = documentDirectory?.appendingPathComponent(fileName) else {
            return nil
        }
        return URL(string: realmPath)
    }
    
    
    //MARK: - DAO
    
    override open func persist(_ entity: Model) throws {
        if let entry = readFromRealm(entity.entityId) {
            try autoreleasepool {
                realm().beginWrite()
                translator.fill(entry, fromEntity: entity)
                try realm().commitWrite()
            }
        } else {
            let entry = RealmModel()
            translator.fill(entry, fromEntity: entity)
            try write(entry)
        }
    }
    
    
    open override func persist(_ entities: [Model]) throws {
        let entries = List<RealmModel>()
        entries.append(objectsIn: entities.flatMap { self.readFromRealm($0.entityId) })
        
        try autoreleasepool {
            realm().beginWrite()
            translator.fill(entries, fromEntities: entities)
            
            entries.forEach {
                self.realm().create(RealmModel.self, value: $0, update: true)
            }
            
            try realm().commitWrite()
        }
    }
    
    
    override open func read(_ entityId: String) -> Model? {
        guard let entry = readFromRealm(entityId) else {
            return nil
        }
        
        let entity = Model()
        translator.fill(entity, fromEntry: entry)
        
        return entity
    }
    
    
    open override func read() -> [Model] {
        return readFromRealm().map {
            let entity = Model()
            self.translator.fill(entity, fromEntry: $0)
            return entity
        }
    }
    
    
    open override func read(predicatedBy predicate: NSPredicate?) -> [Model] {
        return read(predicatedBy: predicate, orderedBy: nil)
    }
    
    
    open override func read(
        orderedBy field: String?,
        ascending: Bool) -> [Model] {
        
        return read(predicatedBy: nil, orderedBy: field, ascending: ascending)
    }
    
    
    open override func read(
        predicatedBy predicate: NSPredicate?,
        orderedBy field: String?,
        ascending: Bool = true) -> [Model] {
        
        var entries = readFromRealm(predicate)
        
        if let field = field {
            entries = entries.sorted(byKeyPath: field, ascending: ascending)
        }
        
        return entries.map {
            let entity = Model()
            self.translator.fill(entity, fromEntry: $0)
            return entity
        }
    }
    
    
    override open func erase() throws {
        let results = readFromRealm()
        let entries: List<RealmModel> = List<RealmModel>()
        
        entries.append(objectsIn: results.map {
            $0 as RealmModel
        })
        
        try self.delete(entries)
    }
    
    
    override open func erase(_ entityId: String) throws {
        guard let entry = readFromRealm(entityId) else {
            return
        }
        try delete(entry)
    }
    
    
    // MARK: - Private
    
    private func write(_ entry: RealmModel) throws {
        try self.realm().write {
            self.realm().create(RealmModel.self, value: entry, update: true)
        }
    }
    
    
    private func write(_ entries: List<RealmModel>) throws {
        try self.realm().write {
            entries.forEach { (e: RealmModel) -> () in
                self.realm().create(RealmModel.self, value: e, update: true)
            }
        }
    }
    
    
    private func readFromRealm(_ entryId: String) -> RealmModel? {
        return self.realm().object(ofType: RealmModel.self, forPrimaryKey: entryId)
    }
    
    
    private func readFromRealm(_ predicate: NSPredicate? = nil) -> Results<RealmModel> {
        let results: Results<RealmModel> = self.realm().objects(RealmModel.self)
        guard let predicate = predicate else {
            return results
        }
        return results.filter(predicate)
    }
    
    
    private func delete(_ entry: RealmModel) throws {
        try self.realm().write {
            cascadeDelete(entry)
        }
    }
    
    
    private func delete(_ entries: List<RealmModel>) throws {
        try self.realm().write {
            cascadeDelete(entries)
        }
    }
    
    
    private func cascadeDelete(_ object: AnyObject?) {
        if let deletable = object as? CascadeDeletionProtocol {
            deletable.objectsToDelete.forEach { child in
                cascadeDelete(child)
            }
        }
        
        if let realmArray = object as? ListBase {
            for i in 0..<realmArray.count {
                let object = realmArray._rlmArray[UInt(i)]
                cascadeDelete(object)
            }
        }
        
        if let realmObject = object as? Object {
            self.realm().delete(realmObject)
        }
    }
    
    private func realm() -> Realm {
        return try! Realm(configuration: configuration)
    }
    
}
