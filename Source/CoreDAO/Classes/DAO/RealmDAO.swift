//
//  RealmDAO.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import Realm
import RealmSwift


private struct RealmConstant {
    fileprivate static var databasePath = ""
    fileprivate static var databaseFileName = "Database.realm"
    fileprivate static var databaseVersion: UInt64 = 1
}


open class RealmDAO<Model: Entity, RealmModel: RLMEntry>: DAO<Model> {
    
    fileprivate let translator: RealmTranslator<Model, RealmModel>
    
    // MARK: Public
    // MARK: DAO
    
    override open func persist(_ entity: Model) throws
    {
        let entry: RealmModel = self.translator.toEntry(entity)
        return try self.writeTransaction(entry)
    }
    
    override open func persistAll(_ entities: [Model]) throws
    {
        let entries: List<RealmModel> = self.translator.toEntries(entities)
        return try self.writeEntriesTransaction(entries)
    }
    
    override open func read(_ entityId: String) -> Model?
    {
        guard let entry = self.readEntryWithId(entityId) else { return nil }
        return self.translator.toEntity(entry)
    }
    
    override open func readAll() -> [Model]
    {
        var entites: [Model] = []
        let result = self.readAllEntriesPredicated(nil)
        result.forEach { (entry) -> () in
            entites.append(self.translator.toEntity(entry))
        }
        return entites
    }
    
    override open func readAll(predicate: NSPredicate?) -> [Model] {
        return self.readAll(predicate: predicate, orderBy: nil)
    }
    
    override open func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        return self.readAll(predicate: nil, orderBy: field, ascending: ascending)
    }
    
    override open func readAll(predicate: NSPredicate?,
                               orderBy field: String?,
                               ascending: Bool = true) -> [Model]
    {
        var entities: [Model]! = []
        var results: Results<RealmModel> = self.readAllEntriesPredicated(predicate)
        
        if let field = field {
            results = results.sorted(byProperty: field, ascending: ascending)
        }
        
        entities.append(contentsOf: results.map { entry in self.translator.toEntity(entry) } )
        return entities
    }
    
    override open func erase() throws
    {
        let results = self.readAllEntriesPredicated(nil)
        let entries: List<RealmModel> = List<RealmModel>()
        
        entries.append(objectsIn: results.map { $0 as RealmModel })
        
        try self.deleteEntriesTransaction(entries)
    }
    
    override open func erase(_ entityId: String) throws
    {
        guard let entry = self.readEntryWithId(entityId) else { return }
        try self.deleteEntryTransaction(entry)
    }
    
    
    // MARK: RealmDAO
    // MARK: Публичные методы
    
    public init(translator: RealmTranslator<Model, RealmModel>,
                databaseFileName: String,
                databaseVersion: UInt64)
    {
        self.translator = translator
        super.init()
        self.loadDefaultRealmFromFileName(databaseFileName, migrateToSchemaVersion: databaseVersion)
    }
    
    public convenience init(translator: RealmTranslator<Model, RealmModel>)
    {
        self.init(translator: translator,
            databaseFileName: RealmConstant.databaseFileName,
            databaseVersion: RealmConstant.databaseVersion)
    }
    
    open class func assignDatabaseFilename(_ fileName: String)
    {
        RealmConstant.databaseFileName = fileName
    }
    
    open class func databaseFileName() -> String
    {
        return RealmConstant.databaseFileName
    }
    
    open class func assignDatabaseVersion(_ version: UInt64)
    {
        RealmConstant.databaseVersion = version
    }
    
    open class func databaseVersion() -> UInt64
    {
        return RealmConstant.databaseVersion
    }
    
    open class func assignDatabasePath(_ databasePath: String)
    {
        RealmConstant.databasePath = databasePath
    }
    
    open class func databasePath() -> String {
        if !RealmConstant.databasePath.isEmpty {
            return RealmConstant.databasePath

        } else {
            let documentDirectory = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true).first
            return documentDirectory ?? ""
        }
    }
    
    // MARK: Приватные методы
    
    fileprivate func writeTransaction(_ entry: RealmModel) throws
    {
        try self.realm().write {
            self.realm().create(self.translator.entryClassName, value: entry, update: true)
        }
    }
    
    fileprivate func writeEntriesTransaction(_ entries: List<RealmModel>) throws
    {
        try self.realm().write {
            entries.forEach { (e: RealmModel) -> () in
                self.realm().create(self.translator.entryClassName, value: e, update: true)
            }
        }
    }
    
    fileprivate func readEntryWithId(_ entryId: String) -> RealmModel?
    {
        return self.realm().object(ofType: self.translator.entryClassName, forPrimaryKey: entryId)
    }
    
    fileprivate func readAllEntriesPredicated(_ predicate: NSPredicate?) -> Results<RealmModel>
    {
        let results: Results<RealmModel> = self.realm().objects(self.translator.entryClassName)
        guard let predicate = predicate else { return results }
        return results.filter(predicate)
    }
    
    fileprivate func deleteEntryTransaction(_ entry: RealmModel) throws
    {
        try self.realm().write {
            self.cascadeDelete(entry)
        }
    }
    
    fileprivate func deleteEntriesTransaction(_ entries:List<RealmModel>) throws
    {
        try self.realm().write {
            self.cascadeDelete(entries)
        }
    }
    
    fileprivate func cascadeDelete(_ object: AnyObject?)
    {
        if let deletable = object as? CascadeDeletionProtocol {
            deletable.objectsToDelete().forEach { child in
                self.cascadeDelete(child)
            }
        }
        
        if let realmArray = object as? ListBase {
            for i in 0..<realmArray.count {
                let object = realmArray._rlmArray[UInt(i)]
                self.cascadeDelete(object)
            }
        }
        
        if let realmObject = object as? Object {
            self.realm().delete(realmObject)
        }
    }
    
    
    // MARK: Private
    
    fileprivate func realm() -> Realm
    {
        return try! Realm()
    }
    
    fileprivate func defaultRealmPathIsEqualToPath(_ path: URL?) -> Bool
    {
        guard let path = path else { return false }
        return Realm.Configuration.defaultConfiguration.fileURL == path
    }
    
    fileprivate func loadDefaultRealmFromFileName(_ fileName: String, migrateToSchemaVersion: UInt64)
    {
        guard let path = self.pathForFileName(fileName) else { fatalError("Cant find path for DB with filename: \(fileName) v.\(migrateToSchemaVersion)") }
        if (self.defaultRealmPathIsEqualToPath(path)) { return }
        
        self.assignDefaultRealmPath(path)
        self.migrateDefaultRealmToSchemaVersion(migrateToSchemaVersion)
    }
    
    fileprivate func pathForFileName(_ fileName: String) -> URL?
    {
        let path = URL(fileURLWithPath: RealmDAO.databasePath())
        let realmPath = path.appendingPathComponent(fileName)
        return realmPath
    }
    
    fileprivate func assignDefaultRealmPath(_ path: URL)
    {
        var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
        configuration.fileURL = path
        Realm.Configuration.defaultConfiguration = configuration
    }
    
    fileprivate func migrateDefaultRealmToSchemaVersion(_ version: UInt64)
    {
        var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = version
        Realm.Configuration.defaultConfiguration = configuration
    }
    
}
