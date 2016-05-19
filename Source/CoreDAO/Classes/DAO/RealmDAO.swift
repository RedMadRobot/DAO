//
//  RealmDAO.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


private struct RealmConstant {
    private static var databaseFileName = "Database.realm"
    private static var databaseVersion: UInt64 = 1
}


public class RealmDAO<Model: Entity, RealmModel: RLMEntry>: DAO<Model> {
    
    private let translator: RealmTranslator<Model, RealmModel>
    
    // MARK: Public
    // MARK: DAO
    
    override public func persist(entity: Model) throws
    {
        let entry: RealmModel = self.translator.toEntry(entity)
        return try self.writeTransaction(entry)
    }
    
    override public func persistAll(entities: [Model]) throws
    {
        let entries: List<RealmModel> = self.translator.toEntries(entities)
        return try self.writeEntriesTransaction(entries)
    }
    
    override public func read(entityId: String) -> Model?
    {
        guard let entry = self.readEntryWithId(entityId) else { return nil }
        return self.translator.toEntity(entry)
    }
    
    override public func readAll() -> [Model]
    {
        var entites: [Model] = []
        let result = self.readAllEntriesPredicated(nil)
        result.forEach { (entry) -> () in
            entites.append(self.translator.toEntity(entry))
        }
        return entites
    }
    
    override public func readAll(predicate predicate: NSPredicate?) -> [Model] {
        return self.readAll(predicate: predicate, orderBy: nil)
    }
    
    override public func readAll(orderBy field: String?, ascending: Bool) -> [Model]
    {
        return self.readAll(predicate: nil, orderBy: field, ascending: ascending)
    }
    
    override public func readAll(predicate predicate: NSPredicate?,
                                 orderBy field: String?,
                                 ascending: Bool = true) -> [Model]
    {
        var entities: [Model]! = []
        var results: Results<RealmModel> = self.readAllEntriesPredicated(predicate)
        
        if let field = field {
            results = results.sorted(field, ascending: ascending)
        }
        
        entities.appendContentsOf( results.map { entry in self.translator.toEntity(entry) } )
        return entities
    }
    
    override public func erase() throws
    {
        let results = self.readAllEntriesPredicated(nil)
        let entries: List<RealmModel> = List<RealmModel>()
        
        entries.appendContentsOf( results.map { $0 as RealmModel })
        
        try self.deleteEntriesTransaction(entries)
    }
    
    override public func erase(entityId: String) throws
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
    
    public class func assignDatabaseFilename(fileName: String)
    {
        RealmConstant.databaseFileName = fileName
    }
    
    public class func databaseFileName() -> String
    {
        return RealmConstant.databaseFileName
    }
    
    public class func assignDatabaseVersion(version: UInt64)
    {
        RealmConstant.databaseVersion = version
    }
    
    public class func databaseVersion() -> UInt64
    {
        return RealmConstant.databaseVersion
    }
    
    // MARK: Приватные методы
    
    private func writeTransaction(entry: RealmModel) throws
    {
        try self.realm().write {
            self.realm().create(self.translator.entryClassName, value: entry, update: true)
        }
    }
    
    private func writeEntriesTransaction(entries: List<RealmModel>) throws
    {
        try self.realm().write {
            entries.forEach { (e: RealmModel) -> () in
                self.realm().create(self.translator.entryClassName, value: e, update: true)
            }
        }
    }
    
    private func readEntryWithId(entryId: String) -> RealmModel?
    {
        return self.realm().objectForPrimaryKey(self.translator.entryClassName, key: entryId)
    }
    
    private func readAllEntriesPredicated(predicate: NSPredicate?) -> Results<RealmModel>
    {
        let results: Results<RealmModel> = self.realm().objects(self.translator.entryClassName)
        guard let predicate = predicate else { return results }
        return results.filter(predicate)
    }
    
    private func deleteEntryTransaction(entry: RealmModel) throws
    {
        // TODO: Реализовать каскадное удалени
        try self.realm().write {
            self.realm().delete(entry)
        }
    }
    
    private func deleteEntriesTransaction(entries:List<RealmModel>) throws
    {
        // TODO: Реализовать каскадное удалени
        try self.realm().write {
            self.realm().delete(entries)
        }
    }
    
    
    // MARK: Private
    
    private func realm() -> Realm
    {
        return try! Realm()
    }
    
    private func defaultRealmPathIsEqualToPath(path: NSURL?) -> Bool
    {
        guard let path = path else { return false }
        return Realm.Configuration.defaultConfiguration.fileURL == path
    }
    
    private func loadDefaultRealmFromFileName(fileName: String, migrateToSchemaVersion: UInt64)
    {
        guard let path = self.pathForFileName(fileName) else { fatalError("Cant find path for DB with filename: \(fileName) v.\(migrateToSchemaVersion)") }
        if (self.defaultRealmPathIsEqualToPath(path)) { return }
        
        self.assignDefaultRealmPath(path)
        self.migrateDefaultRealmToSchemaVersion(migrateToSchemaVersion)
    }
    
    private func pathForFileName(fileName: String) -> NSURL?
    {
        let documentDirectory: NSString? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        guard let realmPath = documentDirectory?.stringByAppendingPathComponent(fileName) else { return nil }
        return NSURL(string: realmPath)
    }
    
    private func assignDefaultRealmPath(path: NSURL)
    {
        var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
        configuration.fileURL = path
        Realm.Configuration.defaultConfiguration = configuration
    }
    
    private func migrateDefaultRealmToSchemaVersion(version: UInt64)
    {
        var configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = version
        Realm.Configuration.defaultConfiguration = configuration
    }
    
}